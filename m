Return-Path: <dqfext@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4yoSRAAq6ByLw23273SotPtzJ6Q/E4R2A/SjkRQDriw=;
 b=YXPZyWlH9RSSgnW5j4iBJYF58R50FLIv94XzPhsCL6y80GnIplmbo8VNoGUnNVX1Go
 q/RLTVUCtpjzdgWr8DqtYQXjJqiPUZKMk5EH11tX4xMI0VUtBICfyyWP7XoQfjzlWF1x
 MUSMdiYcJwUcGTW58A0DeGjHS6bbV16Z3Bvd/Xmr7O6ZqkIsgX+PEdjnwUAMeQSa33FV
 QcvCAKO550XbIg5IuuSpIrjH2CGQcHtR8QJlHR8l8UthPCOIM9xr82JA2t1b2UARa/NG
 RxNOCms/KgmbjQAnvWmhEQxJP9qeHQ13fnJkk5XxCF9nX1URKTmNnjQ1/xNK3AfTSfTZ
 eOYg==
MIME-Version: 1.0
References: <20200419161946.19984-1-dqfext@gmail.com>
 <20200419164251.GM836632@lunn.ch>
In-Reply-To: <20200419164251.GM836632@lunn.ch>
From: DENG Qingfang <dqfext@gmail.com>
Message-ID: <CALW65jYmcZJoP_i5=bgeWpcibzOmEPne3mHyBngE5bTiOZreDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [RFC PATCH net-next] net: bridge: fix client roaming
 from DSA user port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 20 Apr 2020 04:03:29 -0000
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

On Mon, Apr 20, 2020 at 12:42 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Apr 20, 2020 at 12:19:46AM +0800, DENG Qingfang wrote:
> > When a client roams from a DSA user port to a soft-bridged port (such as WiFi
> > interface), the left-over MAC entry in the switch HW is not deleted, causing
> > inconsistency between Linux fdb and the switch MAC table. As a result, the
> > client cannot talk to other hosts which are on that DSA user port until the
> > MAC entry expires.
> >
> > Solve this by notifying switchdev fdb to delete the leftover entry when an
> > entry is updated. Remove the added_by_user check in DSA
> >
> > Signed-off-by: DENG Qingfang <dqfext@gmail.com>
> > ---
> > I tried this on mt7530 and mv88e6xxx, but only mt7530 works.
> > In previous discussion[1], Andrew Lunn said "try playing with auto learning
> > for the CPU port" but it didn't work on mv88e6xxx either
>
> Hi Deng
>
> We should probably first define how we expect moving MAC to work. Then
> we can make any core fixes, and driver fixes.
>
> For DSA, we have assumed that the software bridge and the hardware
> bridge are independent, each performs its own learning. Only static
> entries are kept in sync.
>
> How should this separate learning work for a MAC address which moves?

When a client moves from a hardware port (e.g. sw0p1) to a software port (wlan0)
or another hardware port that belongs to a different switch (sw1p1),
that MAC entry
in sw0's MAC table should be deleted, or replaced with the CPU port as
destination,
by DSA. Otherwise the client is unable to talk to other hosts on sw0 because sw0
still thinks the client is on sw0p1.

Discussion in OpenWrt GitHub:
https://github.com/openwrt/openwrt/pull/2798#issuecomment-602221971


>
>     Andrew
