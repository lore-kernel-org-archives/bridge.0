Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 869D341DF3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16ABC41DEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684873793;
 bh=IHjbqY3L6Kyfcn6EpLoF0/oL2Mhj/pa0C03BNaUDdRA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=f927S0xcFxI0gxvFiUOfBlRQurEehM21aLB0J2XqXylNcF4K2tWGunR3CsmaKWnKZ
 HsjK0JEWYUUCJx3qGRXgBdfxOa9p6j3+3UnOCp3uQxeIeGslL8zGOkV7yGLECXoFCU
 EnEtYG0tkE/5yel26sT1dLtezMniy+BGxpSScMU1FZwSvVcrpSTnVG5R18UOqDcElG
 LOKrPwldMCMb/QONgY2/JqVXJCFCh8M8SuVOqpj2ZH0tCXfxg8aLLLucnfckhxROH9
 bUj+nt1hvd0nkxWTeLOJjrELsoyUU9WggNpwGHAlXgyRCM22bU7CyMcCrmfGtsJNZi
 OROB0fJRGbHYQ==
Date: Tue, 23 May 2023 13:29:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230523132951.623288cb@kernel.org>
In-Reply-To: <ZGx0/hwPmFFN2ivS@shredder>
References: <20230518113328.1952135-1-idosch@nvidia.com>
 <20230518113328.1952135-2-idosch@nvidia.com>
 <1ed139d5-6cb9-90c7-323c-22cf916e96a0@blackwall.org>
 <ZGd+9CUBM+eWG5FR@shredder> <20230519145218.659b0104@kernel.org>
 <ZGx0/hwPmFFN2ivS@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/5] skbuff: bridge: Add layer 2 miss
 indication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On Tue, 23 May 2023 11:10:38 +0300 Ido Schimmel wrote:
> > Can we possibly put the new field at the end of the CB and then have TC
> > look at it in the CB? We already do a bit of such CB juggling in strp
> > (first member of struct sk_skb_cb).  
> 
> Using the CB between different layers is very fragile and I would like
> to avoid it. Note that the skb can pass various layers until hitting the
> classifier, each of which can decide to memset() the CB.
> 
> Anyway, I think I have a better alternative. I added the 'l2_miss' bit
> to the tc skb extension and adjusted the bridge to mark packets via this
> extension. The entire thing is protected by the existing 'tc_skb_ext_tc'
> static key, so overhead is kept to a minimum when feature is disabled.
> Extended flower to enable / disable this key when filters that match on
> 'l2_miss' are added / removed.
> 
> bridge change to mark the packet:
> https://github.com/idosch/linux/commit/3fab206492fcad9177f2340680f02ced1b9a0dec.patch
> 
> flow_dissector change to dissect the info from the extension:
> https://github.com/idosch/linux/commit/1533c078b02586547817a4e63989a0db62aa5315.patch
> 
> flower change to enable / disable the key:
> https://github.com/idosch/linux/commit/cf84b277511ec80fe565c41271abc6b2e2f629af.patch
> 
> Advantages compared to the previous approach are that we do not need a
> new bit in the skb and that overhead is kept to a minimum when feature
> is disabled. Disadvantage is that overhead is higher when feature is
> enabled.
> 
> WDYT?

Sounds good, yup. Thanks!
