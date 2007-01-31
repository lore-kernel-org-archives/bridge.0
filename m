Message-ID: <45BFE8FE.8010309@atmark-techno.com>
Date: Wed, 31 Jan 2007 09:55:26 +0900
From: chris mcharg <chris@atmark-techno.com>
MIME-Version: 1.0
References: <H000006900128c81.1170203983.mail.pacificwireless.net.au@MHS>
In-Reply-To: <H000006900128c81.1170203983.mail.pacificwireless.net.au@MHS>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Multiple bridges in one box
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Leigh Sharpe <lsharpe@pacificwireless.com.au>
Cc: bridge <bridge@lists.osdl.org>

  > Hi,

Gidday

> 
> I'm looking at building a box like this and I'm wondering if it's doable.
[...]
> 
> Secondly can I bridge a tun device with a physical device, say tun0 and eth0
> bridged to form br0.
> 

I think this is pretty much standard practice when using openvpn.

http://openvpn.net/bridge.html

However, I think you might want to use a tap device as tun is IP level, 
according to this doc:

http://www.linux-m32r.org/lxr/http/source/Documentation/networking/tuntap.txt

Chris
