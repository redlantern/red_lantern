echo -e "------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"plain\"\r\n\r\nsupport 2\n\n\nDaphne Rouw\n\nTwitter: @daphsta | Skype: daphsta \n\n\n \n\n\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"html\"\r\n\r\n<html><head></head><body style=\"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; \">support 2<br><div>\n<br>\n<br>\n<div id=\"sig\" style=\"width:300px;height: 52px;background:#FFEBCD ;padding: 10px; font-family:Helvetica; font-size: 12px; color: #FA8072;\">\n	\n		<span style=\"font-size:14px\"><strong style=\"color: #696969\">Daphne Rouw</strong></span><br>\n\n          <br><bold> Twitter: @daphsta | Skype: daphsta </bold><br>		\n     </div>\n		<div style=\"clear:both\"></div>\n\n<br>\n<br>\n \n\n</div>\n<br></body></html>\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"reply_plain\"\r\n\r\n\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"headers[Return-Path]\"\r\n\r\nyiingshan@gmail.com\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"headers[Received][0]\"\r\n\r\nby mail-pb0-f54.google.com with SMTP id ro2so2649164pbb.13 for <402ad69ba37b07a1538b@cloudmailin.net>; Fri, 05 Jul 2013 21:08:38 -0700\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"headers[Received][1]\"\r\n\r\nfrom [192.168.43.160] ([203.17.70.49]) by mx.google.com with ESMTPSA id zn4sm11091536pac.21.2013.07.05.21.08.35 for <402ad69ba37b07a1538b@cloudmailin.net> (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128); Fri, 05 Jul 2013 21:08:37 -0700\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"headers[Date]\"\r\n\r\nSat, 06 Jul 2013 14:08:38 +1000\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"headers[From]\"\r\n\r\nDaphne Chan <yiingshan@gmail.com>\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"headers[To]\"\r\n\r\n402ad69ba37b07a1538b@cloudmailin.net\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"headers[Message-ID]\"\r\n\r\n<5637FBEF-EAD2-4AB5-81D0-59ECAF84E200@gmail.com>\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"headers[Subject]\"\r\n\r\nsupport 2\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"headers[Mime-Version]\"\r\n\r\n1.0\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"headers[DKIM-Signature]\"\r\n\r\nv=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113; h=from:content-type:subject:date:message-id:to:mime-version:x-mailer; bh=ayR8pLJGV5q5XmyZ4FASP1j/zAl4sTWn5sVoxcYvAO0=; b=sjgpZx3H3M5ohjnMBhzmyfaCMuE/WMbXmQ/EIVKAlrcc/F9ErNIMptxX3YHPRM2cXD 78gVEgdoiZSXxa1xoSb8LHgQSbzBQmx7k/ii8kVjkZs4Be46C2taEWEkEOU93O4gYglj KhEiAtj+lYOOKXaYH9Jtq3DFaOD4g0BXyKQg0LyaJXIjjX72Sv916I+Xup0/YXjWRHkx +IhqLRzFRI0ViaziA3xQSXOcthbcItPcxAQ2CxQC3bYVdyMl6QGT+WAT/yUhMAfTXqza TDg7lJONrS5WIHLRjTyNh+qfcc9O1NssOqcPjYR6C0KsKnp3w0oVmtID7GsWfHHrgtSx 5MfA==\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"headers[X-Received]\"\r\n\r\nby 10.68.131.168 with SMTP id on8mr12216662pbb.97.1373083718760; Fri, 05 Jul 2013 21:08:38 -0700 (PDT)\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"headers[X-Mailer]\"\r\n\r\nApple Mail (2.1283)\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"envelope[to]\"\r\n\r\n402ad69ba37b07a1538b@cloudmailin.net\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"envelope[recipients][0]\"\r\n\r\n402ad69ba37b07a1538b@cloudmailin.net\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"envelope[from]\"\r\n\r\nyiingshan@gmail.com\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"envelope[helo_domain]\"\r\n\r\nmail-pb0-f54.google.com\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"envelope[remote_ip]\"\r\n\r\n209.85.160.54\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"envelope[spf][result]\"\r\n\r\nneutral\r\n------cloudmailinboundry\r\nContent-Disposition: form-data; name=\"envelope[spf][domain]\"\r\n\r\ngmail.com\r\n------cloudmailinboundry--" | curl -H 'user-agent:CloudMailin Server' -H 'content-type:multipart/form-data; boundary=----cloudmailinboundry' -H 'connection:close' -H 'host:localhost:3000/inbound' --data-binary @- --request POST http://localhost:3000/inbound
