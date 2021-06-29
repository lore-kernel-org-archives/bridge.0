Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PY/2WH5hnilO8u4PmgXgGiXRhHzf3uFJjP0VaA/hWn4=;
 b=QKSsB4h3ID/kSdb7wt92GbeIhWMNyCrJgByY7HREdDhAvHoD1qW1tudgyyu16IU0F2
 2k9bC3KBxgbFB2zTPpkjB9j+EEYrpp5wyw54cU0rS+QNlajm0IUgfW/LTUZijVmRU4Yr
 3Tpti+RM4el2Jaa8SG4ltVLAkKO9GlE98FEMweO+g5MqB84JolKvEXOvvqz5g45yDxxW
 /724aRYmRxy8bs1+jOoFZpAM9JF+/tDh7I+NWCayDF+vzoDG7tDOvVN4hHvyToDA/3lN
 8PiwjdMkOBRis0vKmzfYQwH3nxTfuafodN7AWZG7kz53fEHtYgeyFth5aWfBw5M7W5NL
 9m4g==
Date: Tue, 29 Jun 2021 22:09:23 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210629190923.kf5utzbhmmgszwwc@skbuf>
References: <20210629140658.2510288-1-olteanv@gmail.com>
 <20210629.115213.547056454675149348.davem@davemloft.net>
 <20210629185822.ir3vp52xkyddm3j3@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629185822.ir3vp52xkyddm3j3@skbuf>
Subject: Re: [Bridge] [PATCH v5 net-next 00/15] RX filtering in DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vladimir.oltean@nxp.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, vivien.didelot@gmail.com, tobias@waldekranz.com

On Tue, Jun 29, 2021 at 09:58:22PM +0300, Vladimir Oltean wrote:
> On Tue, Jun 29, 2021 at 11:52:13AM -0700, David Miller wrote:
> > From: Vladimir Oltean <olteanv@gmail.com>
> > Date: Tue, 29 Jun 2021 17:06:43 +0300
> > 
> > > Changes in v5:
> > > - added READ_ONCE and WRITE_ONCE for fdb->dst
> > > - removed a paranoid WARN_ON in DSA
> > > - added some documentation regarding how 'bridge fdb' is supposed to be
> > >   used with DSA
> > 
> > Vlad, I applied v4, could you please send me relative fixups to v5?
> > 
> > Thank you.
> 
> Thanks for applying. I'm going to prepare the delta patches right now.

Dave, is it possible that you may have applied v5 with the cover letter
from v4? I checked and everything is in its right place:

- the READ_ONCE stuff for fdb->dst:
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/bridge/br_fdb.c#n447
- there is no WARN_ON in DSA switch.c:
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/dsa/switch.c#n167
- the additional documentation chapter is there:
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/Documentation/networking/dsa/configuration.rst#n296

Thanks.
