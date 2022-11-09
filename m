Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 200C84019D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CAE640B03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7g0AbY5/adDRQsHrmygyhM6FzTVG4xjy6DBIzTAO0mk=;
 b=di4Uj0oh7+iqBZqbaRrqFsIeaBk5lzHnPlWP+70SlXufN7d7RjOJrIzWoluXMpU7ob
 PRLFUxAtPWw3qG8bDgGxHlGh+BzNRm+YAZOTaMxGLjjFivHe3gX0ienVyqFBtfEaBB0i
 qLTCxSSx22l7uzAhr3q12mbKTHX18eVdYS2yRx+JsL4XFzNS0m8azxRmG0gpn1+wnevN
 0AW2RlLuAYmhmMnFUP7Dzg+CmaxknJd2sfymxW7NTi6qMQ4G7eTlRVCgWijlHru+iw4f
 F5cWmR2u3KnxtOL/m9O6NRwRVY0pr0wD25OUw/pDR3cm6AYQuNFMgX7ZyZSUGa6ZPAaM
 AbmQ==
Date: Wed, 9 Nov 2022 11:21:07 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221109092107.dzgogolaox7upnit@skbuf>
References: <cover.1667902754.git.petrm@nvidia.com>
 <f433543efdb610ef5a6aba9ac52b4783ff137a13.1667902754.git.petrm@nvidia.com>
 <20221108145929.qmu2gvd5vvgvasyy@skbuf> <Y2tkNa7nnAdeD5Nc@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2tkNa7nnAdeD5Nc@shredder>
Subject: Re: [Bridge] [PATCH net-next 11/15] mlxsw: spectrum_switchdev: Add
 locked bridge port support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>, Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Jiri Pirko <jiri@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>, Eric Dumazet <edumazet@google.com>, mlxsw@nvidia.com, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Wed, Nov 09, 2022 at 10:26:29AM +0200, Ido Schimmel wrote:
> On Tue, Nov 08, 2022 at 04:59:29PM +0200, Vladimir Oltean wrote:
> > Can't really figure out from the patch, sorry. Port security works with
> > LAG offload?
> 
> Yes. It's just that port security needs to be enabled on each of the
> member ports. FDB entries that point to a LAG are programmed with a
> lag_id. When a packet is received from a LAG the hardware will compare
> source_lag_id == lag_id instead of rx_local_port == tx_local_port.

Okay, understood, the concepts are clear.
