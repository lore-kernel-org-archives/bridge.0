From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] Getting dynamic ip address for a bridge
Date: Sat, 28 Aug 2004 11:13:18 +0200
References: <FC3C0DD86B79DF4FA423AF0379A547610155438B@mailguy2.nuvation.com>
In-Reply-To: <FC3C0DD86B79DF4FA423AF0379A547610155438B@mailguy2.nuvation.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408281113.18945.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Oliver King-Smith <oliver.king-smith@nuvation.com>, "'bridge@lists.osdl.org'" <bridge@lists.osdl.org>

On Saturday 28 August 2004 01:42, Oliver King-Smith wrote:
> My script looks like this
>
> ifconfig wlan0 0.0.0.0
> ifconfig eth0 0.0.0.0
> brctl addbr mybridge
> brctl addif eth0
> brctl addif wlan0
> #ifconfig mybridge 192.168.1.136 netmask 255.255.255.0 up
> ifconfig mybridge up
>
> Should I be waiting before I run the ifconfig mybridge up?

"pump -i mybridge" (or using some other dhcp tool) after you last line should 
work just fine.

