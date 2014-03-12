<%--
  Created by IntelliJ IDEA.
  User: huaiwang
  Date: 14-3-12
  Time: 下午4:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.11.0.js"></script>
    <style type="text/css">
        body {
            font-family: Courier "Courier New";
            font-size: 24px;
        }

        .txt {
            font-family: Courier "Courier New";
            font-size: 24px;
            width: 60%;
            min-width: 500px;
            border: 0;
            border-bottom: 1px dotted #444;
            padding: 0;
            margin: 0;
            outline: none;
            line-height: 30px;
        }

        .sel {
            font-family: Courier "Courier New";
            font-size: 24px;
        }
    </style>

</head>
<body>
X36<input type="text" class="txt" id="num_a" value="0123456789876543210123456789876543210"/>

<br/>

<select id="op" class="sel">
    <option value="+">+</option>
    <option value="-">-</option>
    <option value="*">&times;</option>
</select>

<br/>

Y36<input type="text" class="txt" id="num_b" value="9876543210123456789876543210123456789"/>

<br/>
=
<div id="rst"></div>

<button id="btn">Calculate</button>

<script type="text/javascript">
    $(function () {
        $("#btn").click(function () {
            var rst = calc();
            if (rst == 'invalid input!')
                $("#rst").html('invalid input!');
            else
                $("#rst").html('S36' + (rst[0] == -1 ? '-' : '') + rst[1]);
        });
    });

    function calc() {
        var a = $('#num_a').val();
        var b = $('#num_b').val();
        var c = $('#op').val();

        r = /^[+-]?\d+$/;

        if (a.match(r) && b.match(r)) {
            switch (c) {
                case '+':
                    return sum(a, b);
                case '-':
                    return sub(a, b);
                case '*':
                    return mul(a, b);
            }
        } else {
            return 'invalid input!'
        }
    }

    function sum(a, b) {
        var sign_a = a[0] == '-' ? -1 : 1;
        var sign_b = b[0] == '-' ? -1 : 1;

        a = a.replace('+', '').replace('-', '');
        b = b.replace('+', '').replace('-', '');

        if (sign_a * sign_b == 1) {
            return [sign_a, _sum(a, b)]
        } else {
            r = _sub(a, b)
            return [sign_a * r[0], r[1]]
        }
    }

    function _sum(a, b) {
        var len = Math.max(a.length, b.length);

        a = pad_0(len - a.length) + a;
        b = pad_0(len - b.length) + b;

        var t = 0;
        var arr = [];
        for (var i = 0; i < len; i++) {
            var da = parseInt(a.charAt(len - i - 1));
            var db = parseInt(b.charAt(len - i - 1));
            var s = da + db + t;

            arr.push(s % 10);
            t = parseInt(s / 10);
        }

        if (t == 1) arr.push(1);

        while (arr.length > 0) {
            var l = arr.length;
            if (arr[l - 1] == 0) arr.pop();
            else break;
        }

        var rst = '';
        $.each(arr, function (idx, val) {
            rst = val + rst;
        });

        return rst;
    }

    function sub(a, b) {
        var sign_a = a[0] == '-' ? -1 : 1;
        var sign_b = b[0] == '-' ? -1 : 1;

        a = a.replace('+', '').replace('-', '');
        b = b.replace('+', '').replace('-', '');

        if (sign_a == sign_b) {
            r = _sub(a, b);
            return [sign_a * r[0], r[1]];
        } else {
            return [sign_a, _sum(a, b)]
        }
    }

    function _sub(a, b) {
        var len = Math.max(a.length, b.length);

        a = pad_0(len - a.length) + a;
        b = pad_0(len - b.length) + b;

        var sign_rst = 1;

        if (a < b) {
            var t = a;
            a = b;
            b = t;
            sign_rst = -1;
        }

        var t = 0;
        var arr = [];
        for (var i = 0; i < len; i++) {
            var da = parseInt(a.charAt(len - i - 1)) || 0;
            var db = parseInt(b.charAt(len - i - 1)) || 0;

            var s;
            if (da + t < db) {
                s = da + t + 10 - db;
                t = -1;
            } else {
                s = da + t - db;
                t = 0;
            }
            arr.push(s);
        }

        while (arr.length > 0) {
            var l = arr.length;
            if (arr[l - 1] == 0) arr.pop();
            else break;
        }

        var rst = '';
        $.each(arr, function (idx, val) {
            rst = val + rst;
        });

        return [sign_rst, rst];
    }

    function pad_0(n) {
        var arr = [];
        for (var i = 0; i < n; i++) {
            arr.push(0);
        }
        return arr.join('');
    }


    function mul(a, b) {
        var sign_a = a[0] == '-' ? -1 : 1;
        var sign_b = b[0] == '-' ? -1 : 1;

        a = a.replace('+', '').replace('-', '');
        b = b.replace('+', '').replace('-', '');

        var arr = b.split('');
        var len = arr.length;
        var r = '0';
        for(var i = 0; i < len; i++) {
            var n = parseInt(arr[len - i - 1]);
            var m = _mul(a, n);
            r = _sum(r, m + pad_0(i));
        }

        return [sign_a * sign_b, r]
    }

    function _mul(a, n) {
        var arr = a.split('')
        n = parseInt(n);

        var t = 0;
        var len = arr.length;
        var rst = [];
        for(var i = 0; i < len; i++) {
            var m = t + n * parseInt(arr[len - i - 1]);
            rst.push(m % 10);
            t = parseInt(m / 10);
        }

        if(t > 0) {
            rst.push(t);
        }

        var s = '';
        $.each(rst, function (idx, val) {
            s = val + s;
        });

        return s;
    }
</script>

</body>
</html>
