Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=E3/UBDuXc/UMmAXiWRPwW4yrgBs5CuzWGxqSCJFk/HA=;
 b=jWTwiuS5J1LrH6cNNWJ4K0NyE7bDgt9LgcQhvS3W40AjSY7EmaEqafmoyHMSa3VizF
 VoEWDjJDMheSWhOWi+x5jJN2F5AFrOL/bVupo+noUKAbAoVJHeVH+wqHRazBsqnbCIH8
 QKhnL2aSKn5nuHFty6ORYnsb7WsnVurJYPxNIjZcxTJPb4GqhBgc7Qcn7reHuH7jxI+M
 wKHfKCOBuNk69pCNkRVrQ6s5keW2Wl49PGXgCkAzapgAW2/cNVJZcMNtc8xUxclNd28F
 459h0EbhHdNZUZ+rohyB+u+7hR+x1bq5oZMWVyxwy5M3W7SWdewbgV9mY7tEFZbE/dCa
 0kdQ==
Date: Fri, 25 Mar 2022 16:00:03 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220325140003.a4w4hysqbzmrcxbq@skbuf>
References: <20220323123534.i2whyau3doq2xdxg@skbuf> <86wngkbzqb.fsf@gmail.com>
 <20220323144304.4uqst3hapvzg3ej6@skbuf> <86lewzej4n.fsf@gmail.com>
 <20220324110959.t4hqale35qbrakdu@skbuf> <86v8w3vbk4.fsf@gmail.com>
 <20220324142749.la5til4ys6zva4uf@skbuf> <86czia1ned.fsf@gmail.com>
 <20220325132102.bss26plrk4sifby2@skbuf> <86fsn6uoqz.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86fsn6uoqz.fsf@gmail.com>
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

On Fri, Mar 25, 2022 at 02:48:36PM +0100, Hans Schultz wrote:
> > If you'd cache the locked ATU entry in the mv88e6xxx driver, and you'd
> > notify switchdev only if the entry is new to the cache, then you'd
> > actually still achieve something major. Yes, the bridge FDB will contain
> > locked FDB entries that aren't in the ATU. But that's because your
> > printer has been silent for X seconds. The policy for the printer still
> > hasn't changed, as far as the mv88e6xxx, or bridge, software drivers are
> > concerned. If the unauthorized printer says something again after the
> > locked ATU entry expires, the mv88e6xxx driver will find its MAC SA
> > in the cache of denied addresses, and reload the ATU. What this
> > achieves
> 
> The driver will in this case just trigger a new miss violation and add
> the entry again I think.
> The problem with all this is that a malicious attack that spams the
> switch with random mac addresses will be able to DOS the device as any
> handling of the fdb will be too resource demanding. That is why it is
> needed to remove those fdb entries after a time out, which dynamic
> entries would serve.

An attacker sweeping through the 2^47 source MAC address range is a
problem regardless of the implementations proposed so far, no?
If unlimited growth of the mv88e6xxx locked ATU entry cache is a
concern (which it is), we could limit its size, and when we purge a
cached entry in software is also when we could emit a
SWITCHDEV_FDB_DEL_TO_BRIDGE for it, right?
