Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1CA160F09
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA7B760E22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOZ8bUWibnWbrVg28gzxAL4UHOdXJaMEyH09R8fwuDg=;
 b=XvVr6gGIEA8SF+D8A8uNnOHbhHDqofZF6R8PnXn3I+0kTJdeMFXCd3Hq7n0Xo01OiJxKfU+clXsvzDu4LzEeWjWlT9/ybDvTydEzeJ9FhkWe9IkfnlKuSXZqHKy/cK7r3fWO45UvpexO1gU3LZYAReOOrRuGU+UzvZNO8HGPcPl5HrjGSVgGwde5Wpan3IKGkKgLKOwQWiCReMt12adGMLhwoH3su58d4kNFVWZniwNpnRIT9SfclMl2JK+wmnWkpa6F5QWenR/RvULyV7prr12UEC2ChtJAqwbH8pWSbuGWYQkhmInI8qGnxph96tU7p+Az4A+4NGaIQXn0gfmnuw==
Date: Sun, 17 Jul 2022 18:20:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <YtQosZV0exwyH6qo@shredder>
References: <20220708084904.33otb6x256huddps@skbuf>
 <e6f418705e19df370c8d644993aa9a6f@kapio-technology.com>
 <20220708091550.2qcu3tyqkhgiudjg@skbuf>
 <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
 <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
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

On Sun, Jul 17, 2022 at 02:21:47PM +0200, netdev@kapio-technology.com wrote:
> On 2022-07-13 14:39, Ido Schimmel wrote:
> > On Wed, Jul 13, 2022 at 09:09:58AM +0200, netdev@kapio-technology.com
> > wrote:
> 
> > 
> > What are "Storm Prevention" and "zero-DPV" FDB entries?
> 
> They are both FDB entries that at the HW level drops all packets having a
> specific SA, thus using minimum resources.
> (thus the name "Storm Prevention" aka, protection against DOS attacks. We
> must remember that we operate with CPU based learning.)
> 
> > 
> > There is no decision that I'm aware of. I'm simply trying to understand
> > how FDB entries that have 'BR_FDB_ENTRY_LOCKED' set are handled in
> > mv88e6xxx and other devices in this class. We have at least three
> > different implementations to consolidate:
> > 
> > 1. The bridge driver, pure software forwarding. The locked entry is
> > dynamically created by the bridge. Packets received via the locked port
> > with a SA corresponding to the locked entry will be dropped, but will
> > refresh the entry. On the other hand, packets with a DA corresponding to
> > the locked entry will be forwarded as known unicast through the locked
> > port.
> > 
> > 2. Hardware implementations like Spectrum that can be programmed to trap
> > packets that incurred an FDB miss. Like in the first case, the locked
> > entry is dynamically created by the bridge driver and also aged by it.
> > Unlike in the first case, since this entry is not present in hardware,
> > packets with a DA corresponding to the locked entry will be flooded as
> > unknown unicast.
> > 
> > 3. Hardware implementations like mv88e6xxx that fire an interrupt upon
> > FDB miss. Need your help to understand how the above works there and
> > why. Specifically, how locked entries are represented in hardware (if at
> > all) and what is the significance of not installing corresponding
> > entries in hardware.
> > 
> 
> With the mv88e6xxx, a miss violation with the SA occurs when there is no
> entry. If you then add a normal entry with the SA, the port is open for that
> SA of course.

Good

> The zero-DPV entry is an entry that ensures that there is no more miss
> violation interrupts from that SA, while dropping all entries with the
> SA.

Few questions:

1. Is it correct to think of this entry as an entry pointing to a
special /dev/null port?

2. After installing this entry, you no longer get miss violation
interrupts because packets with this SA incur a mismatch violation
(src_port != /dev/null) and therefore discarded in hardware?

3. What happens to packets with a DA matching the zero-DPV entry, are
they also discarded in hardware? If so, here we differ from the bridge
driver implementation where such packets will be forwarded according to
the locked entry and egress the locked port

4. The reason for installing this entry is to suppress further miss
violation interrupts?

5. If not replaced, will this entry always age out after the ageing
time? Not sure what can refresh it given that traffic does not ingress
from the /dev/null port.

Thanks
