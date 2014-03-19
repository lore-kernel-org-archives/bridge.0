Return-Path: <ratheesh.ksz@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=AnfIQeo3lAYiA4tpxhvCxfnv/486qzofL3DzLseZYjs=;
	b=wBb88VZ27vC4tg9JBrA7x1S03E5koxs9T0la0kMR12qRBRN5X7kjUvkD1i8VVGsjkK
	44wGAvP8j8Obl/AkproN0EiD8lUOan0CnRM0HxIgAQUQO2O9lDQKzOsTTS89ZWffjw4k
	2LStL1jpPNMnmKOT+wbZj8+1l2FpmEdLJ9sAOCIPE451VD/R7lRxhaugemOZEaXFc41w
	yotXdJnVBT10GT7bGqpeetrNskvIfgmpW049B5AMY/w767uD4mqy1/Li06N5sBcQqEg4
	RaimBVE8qRXBQPv0gaA7mDFckcSx41xuPhNsPL8ybqC/5jm/wiii4q3t4ARLgFKiG+uJ
	S2Ew==
MIME-Version: 1.0
Date: Wed, 19 Mar 2014 12:18:03 +0530
Message-ID: <CAGZFCEEbccO36dib87TXjVyVudmYhP_Ukgc-MgYOij=adZ=_Tw@mail.gmail.com>
From: ratheesh kannoth <ratheesh.ksz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge] How packet finally reach internal_dev_xmit() routine from
	outside ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, discuss@openvswitch.org

Hi list,


openvswitch internal devices are not real nic. So some routine should
receive the packet  for this interface. Who is receiving packet for
this internal device.
Any clue is really appreciated .


-Ratheesh
