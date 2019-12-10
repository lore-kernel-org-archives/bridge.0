Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:message-id:from:to:cc:subject:in-reply-to:references
 :mime-version:content-disposition:content-transfer-encoding;
 bh=Js+t/imDnAhNiv+s8X3Rf/niWKTG1Cd0eo7I2V5WDgA=;
 b=sPHsMOc88EUoOe/hcIbbxqxMairaW0tiKYqf0W1UhlZNzVRiSjC9z3hJD9lvr2HnZd
 wvtedcSIYZHca7riIAsF2f0XNQ5CmsboZmTTmvCcW2sEGyiAe5XFdFjrxjGDFSAllcbK
 JgXxoM6nLcuIQI0XvL9zhzG1ZmSx6DSnMjjvhsxWAxqkG7f4qdwFuZ7PNHhwcf089JgA
 Iomz230rH6ei8HFpsXXvzughInlwaH1Rr6/7saAFeKuIiTQYhuodD+filjvmkvjvgJ3U
 ENdRRMd9TaYXBEMwxL6tUTI23+6oVnwNwxcHqPM+xcJhHKKmY02nm0J36+efLQw40IUG
 BpTA==
Date: Tue, 10 Dec 2019 13:16:33 -0500
Message-ID: <20191210131633.GB1344570@t480s.localdomain>
From: Vivien Didelot <vivien.didelot@gmail.com>
In-Reply-To: <20191209161345.5b3e757a@hermes.lan>
References: <20191209230522.1255467-1-vivien.didelot@gmail.com>
 <20191209230522.1255467-2-vivien.didelot@gmail.com>
 <20191209161345.5b3e757a@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH iproute2 v2] iplink: add support for STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

Hi Stephen,

On Mon, 9 Dec 2019 16:13:45 -0800, Stephen Hemminger <stephen@networkplumber.org> wrote:
> On Mon,  9 Dec 2019 18:05:22 -0500
> Vivien Didelot <vivien.didelot@gmail.com> wrote:
> 
> > Add support for the BRIDGE_XSTATS_STP xstats, as follow:
> > 
> >     # ip link xstats type bridge_slave dev lan5
> >                         STP BPDU:
> >                           RX: 0
> >                           TX: 39
> >                         STP TCN:
> >                           RX: 0
> >                           TX: 0
> >                         STP Transitions:
> >                           Blocked: 0
> >                           Forwarding: 1
> >                         IGMP queries:
> >                           RX: v1 0 v2 0 v3 0
> >                           TX: v1 0 v2 0 v3 0
> >     ...
> 
> Might I suggest a more concise format:
> 	STP BPDU:  RX: 0 TX: 39
> 	STP TCN:   RX: 0 TX:0
> 	STP Transitions: Blocked: 0 Forwarding: 1
> ...

I don't mind if you prefer this format ;-)
