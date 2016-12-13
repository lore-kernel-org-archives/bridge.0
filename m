Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=4NRVQZgdFUjGBGAueKqQeMYGLe8UHYW/Sr0A3grzrqU=;
	b=wKCt36W6LbehUwZSFBrv2pd+f6tkL+B2lY4HDmFmXGbs9I9AbmegBIpTSMJKw2doV3
	cyT0y8kVzaZYCf5JPDkwN9q7rf6zyK4YO86sNQqp4YWzf+hN26JXHw5tivrXeUsn67oZ
	EQFkucxpaUFaOa+wWxUfeozZbG2/NnJDq/yCSdaPlXWn6YQiA6pQWmMdpDXfTYGyqkbW
	sfuZUWZ83L+oOoxssMVErJIsuF4Gtvg/KxDAjbef6ygodQJAhc9VtETY/fQdgA8Df3vV
	O7wAAM7/XTxUydfZD58bk4dNZxN8XJlr/bU+zdzzzxPAJF9p8AmcESJ8U8FCbgEAM5wm
	0Qog==
Date: Tue, 13 Dec 2016 11:16:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20161213111649.4d983c5f@xeon-e3>
In-Reply-To: <CAAtMjxYTtqk3f5ucZuhP=Uv+bJR7NEYPXrB_vUtX+MpzoMt78Q@mail.gmail.com>
References: <CAAtMjxaGCpd_3axCbinnpDpgR+H3DPn9y+cLabodGiytwckc7A@mail.gmail.com>
	<20161213094128.3fa3f4a5@xeon-e3>
	<CAAtMjxYTtqk3f5ucZuhP=Uv+bJR7NEYPXrB_vUtX+MpzoMt78Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge interface not forwarding DHCP-Broadcast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Balaji J <ping2balaji@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 13 Dec 2016 23:45:52 +0530
Balaji J <ping2balaji@gmail.com> wrote:

> Thanks Stephen.
> Can i attach an interface with IP assigned to it already/statically to a
> bridge?
> So if i understand correctly from your response, i should run dhcpclient on
> br0 interface to assign IP for the same? and Lets say br0 gets an IP
> assigned by DHCP-Server as "12.0.0.1".
> 
> Now my intention is to assign IP address to the Host(say host1) behind
> Router-1 using the DHCP-Server running on/behind Router-2 as shown below:
> Host1 <------> (eth2)[Router-1](eth1:100.1.1.1) <----------EoGRE
> Tunnel----->(eth0:100.1.1.254)[Router-2](DHCP-Server)
> 
> So i thought Bridging eth2 to eth1 in Router-1 is the only way to achieve
> the same as i want the dhcp-broadcast packet from Host-1 to get tunneled
> over EogRE till Router-2. Is this assumption correct? or i am missing
> something here?
> 
> Or i should not assign any IP to eth2 and instead do it in br0 in Router-1?
> 
> Any guidance would be very helpful and greatly appreciated.
> 
> Thanks,
> ...Balaji.J

The problem is that the IP address on an enslaved interface is not used
by the IP stack and packets destined for that address tend to be blackholed.
Packets being sent out get put on the enslaved interface and only sent
out that interface not bridged.

