Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kQFxMWNV4rgLBmw4zuw/aZgjr7Z3zb6XFoOJB/+sV9I=;
 b=r1TZS5QMatjWbLH5EaYwA2CYRpw0u9gnsPDXWvyUsCPRiNauT66mOl+3/MS5XLLglo
 Xy9TaK0MndN3MMWdjbsBlZhh7g34/f4luVrSrcs+1klheGOTmk4rSan5FMqYCi7y86OI
 K+YqrMh+WEjGFFrDHV4daw6GN+LNbewJaNLRRLwzEb64UtO9XBaW8Uzq0dtNPDXX2pPR
 yvEIFo+NHxmiwXB9GXh5uxH3CV9sbJtBJXMwZy1bK8JYpgS2Q72atPzzPa265z8qx7JY
 ObB4xKHZmSed0mgzq1oHOiJ6vUIZw1CDcxp5gekJ6l+TgLx2ffES0suL++/43IVZqu23
 U51Q==
Date: Wed, 11 Dec 2019 15:24:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20191211152446.4334559d@shemminger-XPS-13-9360>
In-Reply-To: <20191210131633.GB1344570@t480s.localdomain>
References: <20191209230522.1255467-1-vivien.didelot@gmail.com>
 <20191209230522.1255467-2-vivien.didelot@gmail.com>
 <20191209161345.5b3e757a@hermes.lan>
 <20191210131633.GB1344570@t480s.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH iproute2 v2] iplink: add support for STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On Tue, 10 Dec 2019 13:16:33 -0500
Vivien Didelot <vivien.didelot@gmail.com> wrote:

> Hi Stephen,
> 
> On Mon, 9 Dec 2019 16:13:45 -0800, Stephen Hemminger <stephen@networkplumber.org> wrote:
> > On Mon,  9 Dec 2019 18:05:22 -0500
> > Vivien Didelot <vivien.didelot@gmail.com> wrote:
> >   
> > > Add support for the BRIDGE_XSTATS_STP xstats, as follow:
> > > 
> > >     # ip link xstats type bridge_slave dev lan5
> > >                         STP BPDU:
> > >                           RX: 0
> > >                           TX: 39
> > >                         STP TCN:
> > >                           RX: 0
> > >                           TX: 0
> > >                         STP Transitions:
> > >                           Blocked: 0
> > >                           Forwarding: 1
> > >                         IGMP queries:
> > >                           RX: v1 0 v2 0 v3 0
> > >                           TX: v1 0 v2 0 v3 0
> > >     ...  
> > 
> > Might I suggest a more concise format:
> > 	STP BPDU:  RX: 0 TX: 39
> > 	STP TCN:   RX: 0 TX:0
> > 	STP Transitions: Blocked: 0 Forwarding: 1
> > ...  
> 
> I don't mind if you prefer this format ;-)

Just trying to reduce the long output. Which is already too long for the xstat as it is.
