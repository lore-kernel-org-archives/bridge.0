Return-Path: <nbd@nbd.name>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
 s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2t7zT74dnx+dmnDDZa8p5RsVN04dddFieKKXDkDW0cc=; b=KrGPvdwi6r065sWBtoN4EQkYEs
 VQowH1kCzRBpcuhjevklP03m6RYV/I186RiNyM4qxOzqoirLw7vh3hTMJtdnv29g26NBUF0kON0bQ
 83I3ZmnbM6kMd4OkZLrMmFX4RJ9/Q+nW7MXv9n2YZGSnR3yNX1JFHek/T+LnRIwsH0Gk=;
References: <20200816202424.3526-1-linus.luessing@c0d3.blue>
 <20200816150813.0b998607@hermes.lan> <20200823154239.GA2302@otheros>
From: Felix Fietkau <nbd@nbd.name>
Message-ID: <a622b789-ab29-989a-e337-0407c5f0c494@nbd.name>
Date: Sun, 23 Aug 2020 21:49:46 +0200
MIME-Version: 1.0
In-Reply-To: <20200823154239.GA2302@otheros>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [RFC PATCH net-next] bridge: Implement MLD Querier
 wake-up calls / Android bug workaround
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, Stephen Hemminger <stephen@networkplumber.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, gluon@luebeck.freifunk.net, openwrt-devel@lists.openwrt.org, "David S . Miller" <davem@davemloft.net>

On 2020-08-23 17:42, Linus Lüssing wrote:
> On Sun, Aug 16, 2020 at 03:08:13PM -0700, Stephen Hemminger wrote:
>> Rather than adding yet another feature to the bridge, could this hack be done by
>> having a BPF hook? or netfilter module?
> 
> Hi Stephen,
> 
> Thanks for the constructive feedback and suggestions!
> 
> The netfilter approach sounds tempting. However as far as I know
> OpenWrt's firewall has no easy layer 2 netfilter integration yet.
> So it has default layer 3 netfilter rules, but not for layer 2.
> 
> Ideally I'd want to work towards a solution where things "just
> work as expected" when a user enables "IGMP Snooping" in the UI.
> I could hack the netfilter rules into netifd, the OpenWrt network
> manager, when it configures the bridge. But not sure if the
> OpenWrt maintainers would like that...
> 
> Any preferences from the OpenWrt maintainers side?
Enabling bridge netfilter comes with a very significant performance
cost, so it's not something that should be done in a default configuration.

- Felix
