Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=kmm/3nLHqjesZ7TDBqVTySDnC/Z+EJm2cejcxqFnffI=;
	b=RQ4HfDwD7qI7mWsAj0WpY6w4p994/+kHgrXICBnHZQo+yyqAvlAkpsqoWA9Gm0PdJ9
	9bCxcDH2ogwu9EMxaVKkDQop3EhEMHEtprwAx8wfN0OaTckRxPxIV00QFGq4kfA4phES
	E/jiZ5Poq1N8GXaGM7pdzTZm5nlRoUIWwegZhpXDdo4dVpNb8GWie5q1SQ7Et51uaJhg
	2elNtMGwryQ+1qX6Q7DAvTGttWz2+Oleqd+QUsxahEUrya5NqD/RqDKx3OR0c90CHNLM
	pWtInmAsBV6QkE7EzeOy6agXK4if5mxTM2tMwYh+c0CO2TO4QA6Xnzrn8E2eNnEv+DX8
	CJNw==
Date: Sat, 7 Jan 2017 09:47:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170107094725.45ef4887@xeon-e3>
In-Reply-To: <CAJiguwoUWDOYoeU9UPm9FoXhO3h9ZOhjrpW_ijyyG+9eBYMm0g@mail.gmail.com>
References: <CAJiguwoUWDOYoeU9UPm9FoXhO3h9ZOhjrpW_ijyyG+9eBYMm0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] RSTP, vlans and bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: gellert grindelwald <grindelwaldus@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 6 Jan 2017 18:15:24 +0300
gellert grindelwald <grindelwaldus@gmail.com> wrote:

> I tried to figure out how to setup RSTP on Linux with VLANs and bridges
> involved and now am completely confused.
> 
> I am trying to bridge three interfaces, two of which are supposed to act as
> trunk (hdlc0 and hdlc1) and one is supposed to act as access port (eth0). I
> also need to enable RSTP on each interface included in bridge, but with the
> configuration listed below RSTP packets are sent via hdlc0 and hdlc1 tagged
> (!) so other devices (like Cisco switches) reject them.
> 
> Here's my configuration:
> 
> ifconfig eth0 up
> 
> 
> ifconfig hdlc0 up
> ifconfig hdlc1 up
> 
> vconfig add hdlc0 42
> vconfig add hdlc1 42
> ifconfig hdlc0.42 up
> ifconfig hdlc1.42 up
> 
> 
> brctl addbr br1
> brctl addif br1 eth0
> brctl addif br1 hdlc0.42
> brctl addif br1 hdlc1.42
> 
> ifconfig br1 up
> brctl stp br1 on
> 
> 
> Another question: I also wonder how to configure RSTP in scenarios where I
> have multiple bridges: say eth0 is trunk with vlan 42-42 allowed, vlan 42
> is supposed to pass via hdlc0 and vlan 43 is supposed to go via hdlc1, so I
> have two bridges. If i enable RSTP on both bridges it will (probably) run
> independently on each bridge so I'll face problems soon?

1. If doing vlan and RSTP then you wan to use external Spanning Tree daemon mstp
  https://github.com/mstpd/mstpd
2. Learn to use modern linux network utils (iproute2) to configure network
and vlan.
  https://docs.cumulusnetworks.com/display/CL25/Spanning+Tree+and+Rapid+Spanning+Tree
   
