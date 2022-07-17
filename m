Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7583760AE2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2881860ACC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LbXvWfEaQpT3EOvVscba33ymf3op3INZ0urZAjVoQ+c=;
 b=GOZVLSmxUnmmok7nuMBDud3xiCRYe8eu91x9Qvgxc9cJaBQehuLzC3GA6UqGhwru53
 BHuY1Kk/C6M+StYzq7IsGg0gOcozgvgbA5Kj2hht9Nav7qPpTWi2k9XSlljKSO+JpJMX
 Z3Qu9EiRiTn2OIs0tiU7fWX5zVSlzz28tET+tAmXA2y1J7HU7xOF/jJy7ENI8BX6BPXD
 wHbrmfH7vtJeMT1SfokQhDGBil4sC2dPZfNPVTvOAgXco60vf+iR5YJDthf+rgUV/FT6
 A+l7WkBrCBx6yEvA/l3Oyt1Evqp+HUgzgYv4l43DAlW5yzcWWIGsHJlF9WgAt/FyIeff
 8GWA==
Date: Sun, 17 Jul 2022 16:59:51 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220717135951.ho4raw3bzwlgixpb@skbuf>
References: <20220708091550.2qcu3tyqkhgiudjg@skbuf>
 <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
 <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
 <20220717125718.mj7b3j3jmltu6gm5@skbuf>
 <a6ec816279b282a4ea72252a7400d5b3@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6ec816279b282a4ea72252a7400d5b3@kapio-technology.com>
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Sun, Jul 17, 2022 at 03:09:10PM +0200, netdev@kapio-technology.com wrote:
> On 2022-07-17 14:57, Vladimir Oltean wrote:
> > On Sun, Jul 17, 2022 at 02:21:47PM +0200, netdev@kapio-technology.com
> > wrote:
> > > On 2022-07-13 14:39, Ido Schimmel wrote:
> > > > On Wed, Jul 13, 2022 at 09:09:58AM +0200, netdev@kapio-technology.com
> > > > wrote:
> > > 
> > > >
> > > > What are "Storm Prevention" and "zero-DPV" FDB entries?
> > > 
> > > They are both FDB entries that at the HW level drops all packets
> > > having a
> > > specific SA, thus using minimum resources.
> > > (thus the name "Storm Prevention" aka, protection against DOS
> > > attacks. We
> > > must remember that we operate with CPU based learning.)
> > 
> > DPV means Destination Port Vector, and an ATU entry with a DPV of 0
> > essentially means a FDB entry pointing nowhere, so it will drop the
> > packet. That's a slight problem with Hans' implementation, the bridge
> > thinks that the locked FDB entry belongs to port X, but in reality it
> > matches on all bridged ports (since it matches by FID). FID allocation
> > in mv88e6xxx is slightly strange, all VLAN-unaware bridge ports,
> > belonging to any bridge, share the same FID, so the FDB databases are
> > not exactly isolated from each other.
> 
> But if the locked port is vlan aware and has a pvid, it should not block
> other ports.

I don't understand what you want to say by that. It will block all other
packets with the same MAC SA that are classified to the same FID.
In case of VLAN-aware bridges, the mv88e6xxx driver allocates a new FID
for each VID (see mv88e6xxx_atu_new). In other words, if a locked port
is VLAN-aware and has a pvid, then whatever the PVID may be, all ports
in that same VLAN are still blocked in the same way.

> Besides the fid will be zero with vlan unaware afaik, and all with
> zero fid do not create locked entries.

If by 0 you mean 1 (MV88E6XXX_FID_BRIDGED), then you are correct: ports
with FID 0 (MV88E6XXX_FID_STANDALONE) should not create locked FDB
entries, because they are, well, standalone and not bridged.
Again I don't exactly see the relevance though.
