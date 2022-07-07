Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D76A81376
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 479D8812DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2EAyZ1stZAv+WE/Oe5lCBYtB4ekQDXz6Nn8Oghg9kCU=;
 b=aHVDuq46twN+OtT8574CNtiZ3p3tEfhUL8u6sOlYI9+fP7FO7ykbEZNFUFC3BHekRu
 xA/j1QpdOWmeCE2rtNbFo99qRlvmizsJQzwB5/hvHJkCUajqEXEPuhEguALh8eiqbQQF
 mluxjRV3D7ng9QMNi4SXpjB18hEG+BUkvsUcTiFsUZ+UbD5xTOixnN3f7cmh4wWAu6d5
 dK26p1VfUwXSecDuHXzgSG2LnDTjDwpd44q7pD0LHcJDGeO/4EGNkWhUlmwpQGGNsom5
 wQcoHZMbkPLxSb5mTE+070/irIWuvf3WM7qheHctOiYTf5zXv0Yr2yW4DHSUgN19X1p1
 4VJw==
Date: Thu, 7 Jul 2022 20:15:07 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220707171507.pojkwqhwqk5u6mmn@skbuf>
References: <b78fb006-04c4-5a25-7ba5-94428cc9591a@blackwall.org>
 <86fskyggdo.fsf@gmail.com>
 <040a1551-2a9f-18d0-9987-f196bb429c1b@blackwall.org>
 <86v8tu7za3.fsf@gmail.com>
 <4bf1c80d-0f18-f444-3005-59a45797bcfd@blackwall.org>
 <20220706181316.r5l5rzjysxow2j7l@skbuf>
 <7cf30a3e-a562-d582-4391-072a2c98ab05@blackwall.org>
 <20220706202130.ehzxnnqnduaq3rmt@skbuf>
 <fe456fb0-4f68-f93e-d4a9-66e3bc56d547@blackwall.org>
 <37d59561-6ce8-6c5f-5d31-5c37a0a3d231@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d59561-6ce8-6c5f-5d31-5c37a0a3d231@blackwall.org>
Subject: Re: [Bridge] [PATCH V3 net-next 1/4] net: bridge: add fdb flag to
 extent locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Hans Schultz <schultz.hans@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

Hi Nikolay,

On Thu, Jul 07, 2022 at 05:08:15PM +0300, Nikolay Aleksandrov wrote:
> On 07/07/2022 00:01, Nikolay Aleksandrov wrote:
> > On 06/07/2022 23:21, Vladimir Oltean wrote:
> >> On Wed, Jul 06, 2022 at 10:38:04PM +0300, Nikolay Aleksandrov wrote:
> [snip]
> > I already said it's ok to add hard configurable limits if they're done properly performance-wise.
> > Any distribution can choose to set some default limits after the option exists.
> > 
> 
> Just fyi, and to avoid duplicate efforts, I already have patches for global and per-port software
> fdb limits that I'll polish and submit soon (depending on time availability, of course). If I find
> more time I might add per-vlan limits as well to the set. They use embedded netlink attributes
> to config and dump, so we can easily extend them later (e.g. different action on limit hit, limit
> statistics etc).

So again, to repeat myself, it's nice to have limits on FDB size, but
those won't fix the software bridges that are now out in the open and
can't have their configuration scripts changed.

I haven't had the time to expand on this in a proper change yet, but I
was thinking more along the lines of adding an OOM handler with
register_oom_notifier() in br_fdb_init(), and on OOM, do something, like
flush the FDB from all bridges. There are going to be complications, it
will schedule switchdev, switchdev is going to allocate memory which
we're low on, the workqueues aren't created with WQ_MEM_RECLAIM, so this
isn't necessarily going to be a silver bullet either. But this is what
concerns me the most, the unconfigured bridge killing the kernel so
easily. As you can see, with an OOM handler I'm not so much trying to
impose a fixed limit on FDB size, but do something sensible such that
the bridge doesn't contribute to the kernel dying.
