Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=QdNf1+ADCDYIFdMt/u0EWuhJR3TaXSiM6WxoeP7Eubo=;
 b=Sr4MSscJ3lDmLRDowY0p2F36myUdh5acadCAYqP6y6lRile9Ir7mBytU3OgIgUFZUF
 1CZmrb7YxF0A/b4XWk+rLAlmOMiQjL46TOhhS7qsB53sWCKLsbpKldE6N0S+YBplVoLB
 sBFlPQHIBjuSbG9EpX2gv1OPch3Sk2FPoFD83yjh3A0AQcFC+VJSX/x8knhDDr8Slx3u
 fNNpeIEbuIkrcndC7Dvct4MzKA2XSMmQWZ8MfgMcux/h4yPji5DwAZzb0jiCg572EYsm
 XrKx+EfbQEcGjMEUs/Rmc8WtDaD0J5+3bRqRVXOgWRlbpgBWbh6Kwc1zXesWIptqZbP+
 VjbQ==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <YpiTbOsh0HBMwiTE@shredder>
References: <20220524152144.40527-2-schultz.hans+netdev@gmail.com>
 <Yo+LAj1vnjq0p36q@shredder> <86sfov2w8k.fsf@gmail.com>
 <YpCgxtJf9Qe7fTFd@shredder> <86sfoqgi5e.fsf@gmail.com>
 <YpYk4EIeH6sdRl+1@shredder> <86y1yfzap3.fsf@gmail.com>
 <d88b6090-2ac8-0664-0e38-bb2860be7f6e@blackwall.org>
 <86sfonjroi.fsf@gmail.com>
 <3d93d46d-c484-da0a-c12c-80e83eba31c9@blackwall.org>
 <YpiTbOsh0HBMwiTE@shredder>
Date: Thu, 02 Jun 2022 14:08:41 +0200
Message-ID: <86mtevjmie.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Hans Schultz <schultz.hans@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

>
> I think Hans is testing with mv88e6xxx which dumps entries directly from
> HW via ndo_fdb_dump(). See dsa_slave_port_fdb_do_dump() which sets
> NTF_SELF.
>
> Hans, are you seeing the entry twice? Once with 'master' and once with
> 'self'?
>

When replacing a locked entry it looks like this:

# bridge fdb show dev eth6 | grep 4c
00:4c:4c:4c:4c:4c vlan 1 master br0 extern_learn offload locked

# bridge fdb replace 00:4c:4c:4c:4c:4c dev eth6 vlan 1 master static ; bridge fdb show dev eth6 | grep 4c
00:4c:4c:4c:4c:4c vlan 1 self static

The problem is then that the function
br_fdb_find_rcu(br,eth_hdr(skb)->h_source, vid);
, where the h_source and vid is the entry above, does not find the entry.
My hypothesis was then that this is because of the 'self' flag that I
see.

I am thinking that the function dsa_slave_port_fdb_do_dump() is only for
debug, and thus does not really set any flags in the bridge modules FDB,
but then I don't understand why the above find function does not find
the entry?
