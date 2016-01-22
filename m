Return-Path: <noltari@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=to:from:subject:message-id:date:user-agent:mime-version
	:content-type:content-transfer-encoding;
	bh=sseQt4CvrviBQk+h6QMVMZjTvws91lO77uiO02/6eOw=;
	b=BIW6NNoGe9Pdn2Q+PFLuaRIy16PrwEM/c1+SmFCcdGC3jpegxklkHIBJlcKTNDpHSO
	6nsaD+v5b8p9Ofp1Y8PPUGnmwPefOgi1EJ0VepMw8qlZVliOcghW6ksJizI7hHbhs8X5
	4VcqsL25ilWI89kWrfdr18UrGXTeP54timAJhc8lNxVq51gcFN0T6zUxmMOdVdfWoxG5
	iBkCq+8Wsj3RDD45HKa1aWXCcHLn6A0TspV1lUC2XsZ11BOrBTyctKibMtlfxWuWkCkb
	ijZ8MIlafYozet5rPiJ1sOcJ9ut5L1FmFWzY6N3KMnZ+I3jbSG1+/OkpRUAazztR6zVm
	WUFQ==
From: =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
Message-ID: <56A2993B.4070307@gmail.com>
Date: Fri, 22 Jan 2016 22:03:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] hw csum failure introduced in linux-4.2
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, linus.luessing@c0d3.blue, davem@davemloft.net

 From linux-4.2 there's a "hw csum failure" for bridges using hardware 
checksums when IPv6 multicast traffic is received.

Here are some reports:
https://lkml.org/lkml/2015/12/1/699
https://bugzilla.redhat.com/show_bug.cgi?id=1266601
https://discourse.osmc.tv/t/hw-csum-failure/9990
https://github.com/raspberrypi/linux/issues/1259

I think it may have been introduced in commit 
9afd85c9e4552b276e2f4cfefd622bdeeffbbf26 (net: Export IGMP/MLD message 
validation code) but I haven't done any tests to confirm it.
Any help on this issue would be really appreciated.

Regards,
Álvaro.
