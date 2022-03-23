Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Hpxed2/jWw1SnL0rgO1qfgfRqMtI3k981lUGVm09vkU=;
 b=O2BqoSAh8gk1zLk+rTW6Ok7XPTKVbiDZpl3IsitPRospP8Ri04nFQm3HmjmxWD8esZ
 TXlNJRszB3c+JWkthBN0VqA68eeZNepKxhkBr/i6KRJ0mjx0O83AaS1wxvPJtGncuWbf
 2ioHKTZBpE1JeMuH5lWQmzVAw18gaQUjfSvRNysQbBEA2TAjHJZlPm30ZkCIVy03ALNU
 1ByYkDchELaUiRr9VHUFbLPb7AQWOeloXV4Dw6A1+gwGf/nVEQm6Jwd+SbR2pxBhl0ax
 tpdpy1ZjS5rouUd5ItbkvxVQJHNzQx7NOZeJzU6uousyu3EiPEFktr2bh53oRTJ9kaSI
 fmnQ==
Date: Wed, 23 Mar 2022 16:43:04 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220323144304.4uqst3hapvzg3ej6@skbuf>
References: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
 <20220317093902.1305816-3-schultz.hans+netdev@gmail.com>
 <86o81whmwv.fsf@gmail.com> <20220323123534.i2whyau3doq2xdxg@skbuf>
 <86wngkbzqb.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86wngkbzqb.fsf@gmail.com>
Subject: Re: [Bridge] [PATCH v2 net-next 2/4] net: switchdev: add support
 for offloading of fdb locked flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Wed, Mar 23, 2022 at 01:49:32PM +0100, Hans Schultz wrote:
> >> Does someone have an idea why there at this point is no option to add a
> >> dynamic fdb entry?
> >> 
> >> The fdb added entries here do not age out, while the ATU entries do
> >> (after 5 min), resulting in unsynced ATU vs fdb.
> >
> > I think the expectation is to use br_fdb_external_learn_del() if the
> > externally learned entry expires. The bridge should not age by itself
> > FDB entries learned externally.
> >
> 
> It seems to me that something is missing then?
> My tests using trafgen that I gave a report on to Lunn generated massive
> amounts of fdb entries, but after a while the ATU was clean and the fdb
> was still full of random entries...

I'm no longer sure where you are, sorry..
I think we discussed that you need to enable ATU age interrupts in order
to keep the ATU in sync with the bridge FDB? Which means either to
delete the locked FDB entries from the bridge when they age out in the
ATU, or to keep refreshing locked ATU entries.
So it seems that you're doing neither of those 2 things if you end up
with bridge FDB entries which are no longer in the ATU.
