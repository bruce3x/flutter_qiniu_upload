package com.bruce3x.flutter_qiniu_upload

import com.bruce3x.flutter_qiniu_upload.Api.*
import com.qiniu.android.common.FixedZone
import com.qiniu.android.storage.*
import com.qiniu.android.storage.persistent.FileRecorder
import io.flutter.embedding.engine.plugins.FlutterPlugin
import java.io.File
import java.util.*

class FlutterQiniuUploadPlugin : FlutterPlugin, QiniuHostApi {

    private var binding: FlutterPlugin.FlutterPluginBinding? = null
    private var flutterApi: QiniuFlutterApi? = null

    private val nullReply = QiniuFlutterApi.Reply<Void> { }

    private val manager: UploadManager by lazy {
        val context = binding?.applicationContext
        requireNotNull(context)
        val recorder = FileRecorder(File(context.cacheDir, "qiniu").absolutePath)
        val keyGenerator = KeyGenerator { key, file -> "${key}_._${file.absolutePath.reversed()}" }
        val configuration = Configuration.Builder()
                .useHttps(true)
                .recorder(recorder, keyGenerator)
                .zone(FixedZone.zone0)
                .build()

        UploadManager(configuration)
    }

    private val cancellationStates = hashMapOf<String, Boolean>()

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.binding = binding
        this.flutterApi = QiniuFlutterApi(binding.binaryMessenger)
        QiniuHostApi.setup(binding.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        QiniuHostApi.setup(binding.binaryMessenger, null)
        this.flutterApi = null
        this.binding = null
    }

    override fun upload(request: QiniuUploadRequest): QiniuUploadResult {
        val result = QiniuUploadResult().apply {
            this.requestId = UUID.randomUUID().toString()
            this.request = request
        }
        val completionHandler = UpCompletionHandler { _, _, response ->
            val file = QiniuFile().apply {
                this.hash = response.getString("hash")
                this.key = response.getString("key")
                this.mimeType = response.getString("mimeType")
                this.fileSize = response.getLong("fsize")
            }
            val payload = QiniuTaskComplete().apply {
                this.requestId = result.requestId
                this.file = file
            }
            flutterApi?.taskComplete(payload, nullReply)
        }
        val progressHandler = UpProgressHandler { _, percent ->
            val payload = QiniuTaskUpdate().apply {
                this.requestId = result.requestId
                this.percent = percent
            }
            flutterApi?.taskUpdate(payload, nullReply)
        }
        val cancellationSignal = UpCancellationSignal { cancellationStates.getOrPut(result.requestId, { false }) }
        val options = UploadOptions(null, null, false, progressHandler, cancellationSignal)
        cancellationStates[result.requestId] = false
        manager.put(request.file, request.key, request.token, completionHandler, options)

        return result
    }

    override fun cancel(arg: QiniuUploadResult) {
        cancellationStates[arg.requestId] = false
    }
}
