package kz.airbapay.airbapaysdk

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.lang.StringBuilder

class AirbaPay {
    class Goods(
        val brand: String,  // Брэнд продукта
        val category: String, // Категория продукта
        val model: String, // Модель продукта
        val quantity: Int, // Количество в корзине
        val price: Int // Цена продукта
    )

    companion object {
        fun startProcessing(
            context: Context,
            isProd: Boolean,
            purchaseAmount: Int,
            phone: String,
            invoiceId: String,
            orderNumber: String,
            shopId: String,
            password: String,
            terminalId: String,
            failureBackUrl: String,
            failureCallback: String,
            successBackUrl: String,
            successCallback: String,
            email: String?,
            goods: List<Goods>
        ) {
            val sb = StringBuilder()
            sb.append("isProd=$isProd")
            sb.append("?")

            sb.append("purchaseAmount=$purchaseAmount")
            sb.append("?")

            sb.append("phone=$phone")
            sb.append("?")

            sb.append("invoiceId=$invoiceId")
            sb.append("?")

            sb.append("orderNumber=$orderNumber")
            sb.append("?")

            sb.append("shopId=$shopId")
            sb.append("?")

            sb.append("password=$password")
            sb.append("?")

            sb.append("terminalId=$terminalId")
            sb.append("?")

            sb.append("failureBackUrl=$failureBackUrl")
            sb.append("?")

            sb.append("failureCallback=$failureCallback")
            sb.append("?")

            sb.append("successBackUrl=$successBackUrl")
            sb.append("?")

            sb.append("successCallback=$successCallback")
            sb.append("?")

            if (!email.isNullOrBlank()) { // Если емейла нет, то не нужно отправлять
                sb.append("userEmail=$email")
                sb.append("?")
            }

            goods.forEach { good ->
                sb.append("good_model=${good.model}")
                sb.append("?")
                sb.append("good_quantity=${good.quantity}")
                sb.append("?")
                sb.append("good_brand=${good.brand}")
                sb.append("?")
                sb.append("good_price=${good.price}")
                sb.append("?")
                sb.append("good_category=${good.category}")
                sb.append("?")
            }

            val intent = Intent(context, AirbaPayActivity::class.java)
                .putExtra("airba_pay_args", sb.toString())
                .putExtra("route", "/")
                .putExtra("destroy_engine_with_activity" ,true)

            context.startActivity(intent)
        }
    }
}

class AirbaPayActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val arguments = intent.getStringExtra("airba_pay_args")
        Log.i("Arguments for AirbaPay", arguments.orEmpty())

        val testChannel =
            MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, "airba_pay_channel")
        testChannel.invokeMethod("airba_pay_arguments", arguments)

    }
}
