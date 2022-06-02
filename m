Return-Path: <idosch@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvSoxtoc+URXndjam79/h94i4YQJxQyRHjhboc0kSkA=;
 b=l3o5QBkH/BN8PeT6jlePr142EEy82unzW2ShOmo0ZN6cXsg6EXPNtInyqlBGFU+V6Jct03my19l2lieQjlWbproznVxiow97IcQz0kjoaJrEAzO4xADPmPo9i9jf13wqpfi6LaQhx7wPRDlYYsKaHOfCUH82/XiWBJFrgdWyjae26kOkcNl0p8c+h/784uE4lAqF/0CDVBaR54xvfMl0CR4SZPCOdPbOW3xphKZ4SPWNlejFBNmLUv9GDVZmzuGyhEFWFraIMcslM3gkYOLG+JOvh0Se6Htqs9UU2wuxcnwz5dLawlKegNpJt7CHGtWCnCV2qow6z8eNohn9MME3EA==
Date: Thu, 2 Jun 2022 14:55:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YpilSyiS/1vAbauA@shredder>
References: <86sfov2w8k.fsf@gmail.com> <YpCgxtJf9Qe7fTFd@shredder>
 <86sfoqgi5e.fsf@gmail.com> <YpYk4EIeH6sdRl+1@shredder>
 <86y1yfzap3.fsf@gmail.com>
 <d88b6090-2ac8-0664-0e38-bb2860be7f6e@blackwall.org>
 <86sfonjroi.fsf@gmail.com>
 <3d93d46d-c484-da0a-c12c-80e83eba31c9@blackwall.org>
 <YpiTbOsh0HBMwiTE@shredder> <86pmjrjnzb.fsf@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86pmjrjnzb.fsf@gmail.com>
MIME-Version: 1.0
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
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Thu, Jun 02, 2022 at 01:36:56PM +0200, Hans Schultz wrote:
> On tor, jun 02, 2022 at 13:39, Ido Schimmel <idosch@nvidia.com> wrote:
> > On Thu, Jun 02, 2022 at 01:30:06PM +0300, Nikolay Aleksandrov wrote:
> >> On 02/06/2022 13:17, Hans Schultz wrote:
> >> > On tor, jun 02, 2022 at 12:33, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> >> >> On 02/06/2022 12:17, Hans Schultz wrote:
> >> >>> On tis, maj 31, 2022 at 17:23, Ido Schimmel <idosch@nvidia.com> wrote:
> >> >>>> On Tue, May 31, 2022 at 11:34:21AM +0200, Hans Schultz wrote:
> >> > 
> >> >>> Another issue is that
> >> >>> bridge fdb add MAC dev DEV master static
> >> >>> seems to add the entry with the SELF flag set, which I don't think is
> >> >>> what we would want it to do or?
> >> >>
> >> >> I don't see such thing (hacked iproute2 to print the flags before cmd):
> >> >> $ bridge fdb add 00:11:22:33:44:55 dev vnet110 master static
> >> >> flags 0x4
> >> >>
> >> >> 0x4 = NTF_MASTER only
> >> >>
> >> > 
> >> > I also get 0x4 from iproute2, but I still get SELF entries when I look
> >> > with:
> >> > bridge fdb show dev DEV
> >> > 
> >> 
> >> after the above add:
> >> $ bridge fdb show dev vnet110 | grep 00:11
> >> 00:11:22:33:44:55 master virbr0 static
> 
> >
> > I think Hans is testing with mv88e6xxx which dumps entries directly from
> > HW via ndo_fdb_dump(). See dsa_slave_port_fdb_do_dump() which sets
> > NTF_SELF.
> >
> > Hans, are you seeing the entry twice? Once with 'master' and once with
> > 'self'?
> >
> 
> Well yes, but I get some additional entries with 'self' for different
> vlans. So from clean adding a random fdb entry I get 4 entries on the
> port, 2 with 'master' and two with 'self'.
> It looks like this:
> 
> # bridge fdb add  00:22:33:44:55:66 dev eth6 master static
> # bridge fdb show dev eth6 | grep 55
> 00:22:33:44:55:66 vlan 1 master br0 offload static
> 00:22:33:44:55:66 master br0 offload static

These two entries are added by the bridge driver ('master' is set). You
get two entries because you didn't specify a VLAN, so one entry is
installed with VLAN 0 (no VLAN) and the second is installed because VLAN
1 is configured on eth6.

> 00:22:33:44:55:66 vlan 1 self static

This entry is from the HW. It corresponds to the first entry above.

> 00:22:33:44:55:66 vlan 4095 self static

I assume you are using VLAN 4095 for untagged traffic, so this entry
probably corresponds to the second entry above.

> 
> If I do a replace of a locked entry I only get one with the 'self' flag.

IIUC, your driver is adding the entry to the bridge and with a specific
VLAN. So you have one entry reported by the bridge driver and a
corresponding entry in HW.
