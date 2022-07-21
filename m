Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E2E140635
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7F7640135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hIRt+5psI0fBlG5c+/n/fiysz1qxRkLBoG/4SrkuiJE=;
 b=BydaKhLBRJp/iFzlps/w0ZfZuBS13oz1Ki8ce73VFVSQ6ccbqnmDkqzWL0VtZkitXs
 0RJYQEvWSAhg8BqpEvOOamDiStCjLC/ap9H1jJ1MGsJvT6B4XsOx06wONHzbha5m/ti+
 OgG8QPt+bqnTQq1BO/7l8t4FOeE06spuZy7zEo7wxDrf3JH5r3hHNco4PYXzf7mLI4xo
 G2DLu348tvSB46WOk01bqLu+V95p9/iF27DE1UUGSjW8+HQQT7megPPKwRGShoDxE6tp
 k2HaStBJYxL/pMtg+yNkMKIIxcapAjD3gSuCp9xRv6vkPqIlUZyRm2IOBae59CQCioai
 OkRg==
Date: Thu, 21 Jul 2022 15:04:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220721120459.x6mm4coeoe4ecjfv@skbuf>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-6-netdev@kapio-technology.com>
 <20220717004725.ngix64ou2mz566is@skbuf>
 <3918e3d1a8b78dedc14b950ba1eee8d5@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3918e3d1a8b78dedc14b950ba1eee8d5@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v4 net-next 5/6] net: dsa: mv88e6xxx:
 mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Sun, Jul 17, 2022 at 02:34:22PM +0200, netdev@kapio-technology.com wrote:
> > If I were to randomly guess at almost 4AM in the morning, it has to do with
> > "bridge fdb add" rather than the "bridge fdb replace" that's used for
> > the MAB selftest. The fact I pointed out a few revisions ago, that MAB
> > needs to be opt-in, is now coming back to bite us. Since it's not
> > opt-in, the mv88e6xxx driver always creates locked FDB entries, and when
> > we try to "bridge fdb add", the kernel says "hey, the FDB entry is
> > already there!". Is that it?
> 
> Yes, that sounds like a reasonable explanation, as it adds 'ext learned,
> offloaded' entries. If you try and replace the 'add' with 'replace' in those
> tests, does it work?

Well, you have access to the selftests too... But yes, that is the
reason, and it works when I change 'add' to 'replace', although of
course this isn't the correct solution.

> > As for how to opt into MAB. Hmm. MAB seems to be essentially CPU
> > assisted learning, which creates locked FDB entries. I wonder whether we
> > should reconsider the position that address learning makes no sense on
> > locked ports, and say that "+locked -learning" means no MAB, and
> > "+locked +learning" means MAB? This would make a bunch of things more
> > natural to handle in the kernel, and would also give us the opt-in we
> > need.
> 
> I have done the one and then the other. We need to have some final decision
> on this point. And remember that this gave rise to an extra patch to fix
> link-local learning if learning is turned on on a locked port, which
> resulted in the decision to allways have learning off on locked ports.

I think part of the reason for the back-and-forth was not making a very
clear distinction between basic 802.1X using hostapd, and MAB. While I
agree hostapd doesn't have what to do with learning, for MAB I'm still
wondering. It's the same situation for mv88e6xxx's Port Association
Vector in fact.

> > Side note, the VTU and ATU member violation printks annoy me so badly.
> > They aren't stating something super useful and they're a DoS attack
> > vector in itself, even if they're rate limited. I wonder whether we
> > could just turn the prints into a set of ethtool counters and call it a
> > day?
> 
> Sounds like a good idea to me. :-)

Thinking this through, what we really want is trace points here,
otherwise we'd lose information about which MAC address/VID/FID was it
that caused the violation.
