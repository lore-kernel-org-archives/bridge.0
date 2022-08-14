Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1AA360BD8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA34660BD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSs9O9Rbz5JLZaL+NI0ohyYc2eRUtBZI3X6assqEvas=;
 b=s5PsTHpbDoe8oSq3ktOdaC18l9TY9FW82h77JYX3wlCp0fvmf8I2UB3y6k3YDAPhCNcJ03HKN02cr9p+MhK2FH6xyvdt+LFvKFLTSgxbHX8jenS+0Im3Wro+YVcpSF3NY9SUfw60CO/zs5OB+NU0kek3NlYStmsaAmUNGli2VYbbDaqxebRMb/hT8g+ZPyW6Fzk+IgRnvRpOXfTLurICUIPVA/P7iqWuZGF5oFVhPoe3zPeaiIM7RwLfOPSuLHaHrd2v0uCZOxAg+VRYMWlQjoqDXBbyknfBPtd1CwLFBAveomwpnqiOMtZMeoiPGjr0bmOOt8vatO0w/BGlL6oF8w==
Date: Sun, 14 Aug 2022 17:55:41 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YvkM7UJ0SX+jkts2@shredder>
References: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4cfc6246f621d006af69d4d1f61ed1@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4 net-next 3/6] drivers: net: dsa: add locked
 fdb entry flag to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Fri, Aug 12, 2022 at 02:29:48PM +0200, netdev@kapio-technology.com wrote:
> On 2022-08-11 13:28, Ido Schimmel wrote:
> 
> > > > I'm talking about roaming, not forwarding. Let's say you have a locked
> > > > entry with MAC X pointing to port Y. Now you get a packet with SMAC X
> > > > from port Z which is unlocked. Will the FDB entry roam to port Z? I
> > > > think it should, but at least in current implementation it seems that
> > > > the "locked" flag will not be reset and having locked entries pointing
> > > > to an unlocked port looks like a bug.
> > > >
> > > 
> 
> In general I have been thinking that the said setup is a network
> configuration error as I was arguing in an earlier conversation with
> Vladimir. In this setup we must remember that SMAC X becomes DMAC X in the
> return traffic on the open port. But the question arises to me why MAC X
> would be behind the locked port without getting authed while being behind an
> open port too?
> In a real life setup, I don't think you would want random hosts behind a
> locked port in the MAB case, but only the hosts you will let through. Other
> hosts should be regarded as intruders.
> 
> If we are talking about a station move, then the locked entry will age out
> and MAC X will function normally on the open port after the timeout, which
> was a case that was taken up in earlier discussions.
> 
> But I will anyhow do some testing with this 'edge case' (of being behind
> both a locked and an unlocked port) if I may call it so, and see to that the
> offloaded and non-offloaded cases correspond to each other, and will work
> satisfactory.

It would be best to implement these as additional test cases in the
current selftest. Then you can easily test with both veth pairs and
loopbacks and see that the hardware and software data paths behave the
same.

> 
> I think it will be good to have a flag to enable the mac-auth/MAB feature,
> and I suggest just calling the flag 'mab', as it is short.

Fine by me, but I'm not sure everyone agrees.

> 
> Otherwise I don't see any major issues with the whole feature as it is.

Will review and test the next version.

Thanks
