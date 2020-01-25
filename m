Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jex0E8D9r9+e+6DUpspkCaHnqqzSIrlNGW9e5du01CQ=; b=5giQsy/uLoYYaRrT93K3SefnaL
 2ak6pJiZ13B/nntmKOnGnbQfkxKTSf9olPDjlx05uT//8td9XJDWtGN3XTmauMwXFzJ5z6IsqUADK
 oqCIIOr6kmP05O/UmYqYXlLRO6NItWLs29ASGQKqrvCpGoaH4trZVee1a+ygw/kfIR2I=;
Date: Sat, 25 Jan 2020 17:23:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200125162357.GE18311@lunn.ch>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124203406.2ci7w3w6zzj6yibz@lx-anielsen.microsemi.net>
 <87zhecimza.fsf@linux.intel.com>
 <20200125094441.kgbw7rdkuleqn23a@lx-anielsen.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125094441.kgbw7rdkuleqn23a@lx-anielsen.microsemi.net>
Subject: Re: [Bridge] [RFC net-next v3 00/10] net: bridge: mrp: Add support
 for Media Redundancy Protocol (MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, Vinicius Costa Gomes <vinicius.gomes@intel.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, nikolay@cumulusnetworks.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com

> Lets say that the link between H1 and H2 goes down:
> 
>     +------------------------------------------+
>     |                                          |
>     +-->|H1|<---  / --->|H2|<---------->|H3|<--+
>     eth0    eth1    eth0    eth1    eth0    eth1
> 
> H1 will now observe that the test packets it sends on eth1, is not
> received in eth0, meaninf that the ring is open

Hi Allan

Is H1 the only device sending test packets? It is assumed that H2 and
H3 will forward them? Or does each device send test packets, and when
it stops hearing these packets from a neighbour, it assumes the link
is open?

   Andrew
