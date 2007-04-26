DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
	b=XL/CGBP3Ad6xvI04dztmIC8A8vWKL3QrU5gcbbUi/tlosJYOVM3vhFkEhUBmwNNqopnYDtcl0fmucXwdjAW5lN/it7Cz16mthGjjS28RshrOyd2cwQEFHM2E5sJRF2VgwIYhJJXZPIf50smQJIzXEozGjMLwb+0r1UEYYqYaiEI=
Message-ID: <e0c54c2d0704261251h241b694fx61f854c739b63363@mail.gmail.com>
Date: Thu, 26 Apr 2007 15:51:21 -0400
From: "Larry Cromwell" <lcromwellnc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_128755_18389302.1177617081006"
Subject: [Bridge] Bridging ppp0 and eth0
Reply-To: lcromwell@edgewaternetworks.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_128755_18389302.1177617081006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to bridge a ppp connection to an ethernet connection.  The
documentation says this is possible but when issuing the following:

brctl addif myBridge ppp0

a short message is displayed

br_add_interface: Cannot assign requested address

------=_Part_128755_18389302.1177617081006
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to bridge a ppp connection to an ethernet connection.&nbsp; The documentation says this is possible but when issuing the following:<br><br>brctl addif myBridge ppp0<br><br>a short message is displayed<br><br>br_add_interface: Cannot assign requested address
<br clear="all"><br><br><br>

------=_Part_128755_18389302.1177617081006--
