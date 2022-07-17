Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A56A410C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BEB8409EE
MIME-Version: 1.0
Date: Sun, 17 Jul 2022 18:10:22 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20220717150821.ehgtbnh6kmcbmx6u@skbuf>
References: <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
 <20220717125718.mj7b3j3jmltu6gm5@skbuf>
 <a6ec816279b282a4ea72252a7400d5b3@kapio-technology.com>
 <20220717135951.ho4raw3bzwlgixpb@skbuf>
 <e1c1e7c114f0226b116d9549cea8e7a9@kapio-technology.com>
 <20220717150821.ehgtbnh6kmcbmx6u@skbuf>
Message-ID: <480c7e1e9faa207f37258d8e1b955adc@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 2022-07-17 17:08, Vladimir Oltean wrote:
> On Sun, Jul 17, 2022 at 04:57:50PM +0200, netdev@kapio-technology.com 
> wrote:
>> 
>> Maybe I am just trying to understand the problem you are posing, so 
>> afaics
>> MAC addresses should be unique and having the same MAC address behind 
>> a
>> locked port and a not-locked port seems like a mis-configuration 
>> regardless
>> of vlan setup? As the zero-DPV entry only blocks the specific SA MAC 
>> on a
>> specific vlan, which is behind a locked port, there shouldn't be any
>> problem...?
>> 
>> If the host behind a locked port starts sending on another vlan than 
>> where
>> it got the first locked entry, another locked entry will occur, as the
>> locked entries are MAC + vlan.
> 
> I don't think it's an invalid configuration, I have a 17-port Marvell
> switch which I use as infrastructure to connect my PC with my board 
> farm
> and to the Internet. I've cropped 4 out of those 17 ports for use in
> selftests, effectively now having 2 bridges (br0 used by the selftests
> and br-lan for systemd-networkd).
> 
> Currently all the traffic sent and received by the selftests is done
> through lan1-lan4, but if I wanted to run some bridge locked port tests
> with traffic from my PC, what I'd do is I'd connect a (locked) port 
> from br0
> to a port from br-lan, and my PC would thus gain indirect connectivity 
> to the
> locked port.
> 
> Then I'd send a packet and the switch would create a locked FDB entry
> for my PC's MAC address, but that FDB entry would span across the 
> entire
> MV88E6XXX_FID_BRIDGED, so practically speaking, it would block my PC's
> MAC address from doing anything, including accessing the Internet, i.e.
> traffic that has nothing at all to do with the locked port in br0.
> That isn't quite ok.

Okay, I see the problem you refer to. I think that we have to accept 
some limitations unless you think that just zeroing the specific port 
bit in the DPV would be a better solution, and there wouldn't be caveats 
with that besides having to do a FDB search etc to get the correct DPV 
if I am not too mistaken.

Also trunk ports is a limitation as that is not supported in this 
implementation.
