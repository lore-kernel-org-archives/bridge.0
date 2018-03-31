Return-Path: <joe@perches.com>
Message-ID: <1522519281.11653.16.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Sat, 31 Mar 2018 11:01:21 -0700
In-Reply-To: <20180331173643.GD7460@lunn.ch>
References: <cover.1522479607.git.joe@perches.com>
	<a2d52bbcdcd36c5062bd4fa175df15acd5f8cb85.1522479607.git.joe@perches.com>
	<20180331173643.GD7460@lunn.ch>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 02/12] treewide/net: Rename eth_stp_addr to
 ether_stp_addr
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Sat, 2018-03-31 at 19:36 +0200, Andrew Lunn wrote:
> On Sat, Mar 31, 2018 at 12:05:17AM -0700, Joe Perches wrote:
> > --- a/net/bridge/br_device.c
> > +++ b/net/bridge/br_device.c
> > @@ -1,4 +1,4 @@
> > -/*
> > +gg/*
> 
> Hi Joe
> 
> This does not look good.

Definitely agree with that.  apologies for not noticing.

It's emacs editing nonsense like a superfluous :wq for vim

