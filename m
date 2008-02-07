DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
	bh=cskSGwuvK+3U0Pmvoqra741NHsIlFuH8BA92hMXY/E0=;
	b=IjWG76kg/276wDfrtjiZKRBNPSyW0iyC4Ymu7mU997ErhsXe52jNIKkh4sfZgr5MYXjwuU4BRnd/zK4U2KV4gJASvXsymDnxHQI8Sup87+PQmwx92B03Vjkw6w914mPz8IQsBUzoZxcLuqikmGZEz8mBtGdGAJfQ5E7X59DErNw=
Message-ID: <478c82f00802070519j5214fc6ped4671c2a7dc249f@mail.gmail.com>
Date: Thu, 7 Feb 2008 15:19:06 +0200
From: "Alexander (Sasha) Sirotkin" <sasha.sirotkin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16884_22489757.1202390346074"
Subject: [Bridge] unidirectional traffic and flooding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_16884_22489757.1202390346074
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Suppose there is a unidirectional traffic only (for instance UDP) to one of
the devices connected to a bridge. At the beginning, the bridge will learn
the location of this device from gracious ARP. However, after the timeout
the bridge will forget this information and since there is no traffic from
that device (remember, the traffic is unidirectional, i.e. to the device
only) it will start flooding... and will continue to do so forever.

I have a feeling that I must be not the first person to encounter this
problem. Any ideas ?

------=_Part_16884_22489757.1202390346074
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Suppose there is a unidirectional traffic only (for instance UDP) to one of the devices connected to a bridge. At the beginning, the bridge will learn the location of this device from gracious ARP. However, after the timeout the bridge will forget this information and since there is no traffic from that device (remember, the traffic is unidirectional, i.e. to the device only) it will start flooding... and will continue to do so forever. <br>
<br>I have a feeling that I must be not the first person to encounter this problem. Any ideas ?<br>

------=_Part_16884_22489757.1202390346074--
