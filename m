Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89CCA41916
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F39F418F7
MIME-Version: 1.0
Date: Tue, 20 Sep 2022 23:29:12 +0200
From: netdev@kapio-technology.com
In-Reply-To: <Yx73FOpN5uhPQhFl@shredder>
References: <YwzjPcQjfLPk3q/k@shredder>
 <f1a17512266ac8b61444e7f0e568aca7@kapio-technology.com>
 <YxNo/0+/Sbg9svid@shredder>
 <5cee059b65f6f7671e099150f9da79c1@kapio-technology.com>
 <Yxmgs7Du62V1zyjK@shredder>
 <8dfc9b525f084fa5ad55019f4418a35e@kapio-technology.com>
 <20220908112044.czjh3xkzb4r27ohq@skbuf>
 <152c0ceadefbd742331c340bec2f50c0@kapio-technology.com>
 <20220911001346.qno33l47i6nvgiwy@skbuf>
 <15ee472a68beca4a151118179da5e663@kapio-technology.com>
 <Yx73FOpN5uhPQhFl@shredder>
Message-ID: <086704ce7f323cc1b3cca78670b42095@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 6/6] selftests: forwarding: add
 test of MAC-Auth Bypass to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On 2022-09-12 11:08, Ido Schimmel wrote:
> On Sun, Sep 11, 2022 at 11:23:55AM +0200, netdev@kapio-technology.com 
> wrote:
>> On 2022-09-11 02:13, Vladimir Oltean wrote:
>> > On Fri, Sep 09, 2022 at 03:11:56PM +0200, netdev@kapio-technology.com
>> > wrote:
>> > > > > > On Wed, Sep 07, 2022 at 11:10:07PM +0200, netdev@kapio-technology.com wrote:
>> > > > > > > I am at the blackhole driver implementation now, as I suppose that the
>> > > > > > > iproute2 command should work with the mv88e6xxx driver when adding blackhole
>> > > > > > > entries (with a added selftest)?
>> > > > > > > I decided to add the blackhole feature as new ops for drivers with functions
>> > > > > > > blackhole_fdb_add() and blackhole_fdb_del(). Do you agree with that approach?
>> > > > > >
>> > > > > > I assume you are talking about extending 'dsa_switch_ops'?
>> > > > >
>> > > > > Yes, that is the idea.
>> > > > >
>> > > > > > If so, it's up to the DSA maintainers to decide.
>> > > >
>> > > > What will be the usefulness of adding a blackhole FDB entry from user
>> > > > space?
>> > >
>> > > With the software bridge it could be used to signal a untrusted host
>> > > in
>> > > connection with a locked port entry attempt. I don't see so much use
>> > > other
>> > > that test purposes with the driver though.
>> >
>> > Not a huge selling point, to be honest. Can't the blackhole flag remain
>> > settable only in the device -> bridge direction, with user space just
>> > reading it?
>> 
>> That is possible, but it would of course not make sense to have 
>> selftests of
>> the feature as that would not work unless there is a driver with this
>> capability (now just mv88e6xxx).
> 
> The new "blackhole" flag requires changes in the bridge driver and
> without allowing user space to add such entries, the only way to test
> these changes is with mv88e6xxx which many of us do not have...

I am now building from new system (comp), and the kernel selftests are 
not being installed correctly, so I haven't been able to run the 
selftests yet.

I have made a blackhole selftest, which looks like this:

test_blackhole_fdb()
{
         RET=0

         check_blackhole_fdb_support || return 0

         tcpdump_start $h2
         $MZ $h1 -q -t udp -a $h1 -b $h2
         tcpdump_stop
         tcpdump_show | grep -q udp
         check_err $? "test_blackhole_fdb: No packet seen on initial"
         tcpdump_cleanup

         bridge fdb add `mac_get $h2` dev br0 blackhole
         bridge fdb show dev br0 | grep -q "blackhole"
         check_err $? "test_blackhole_fdb: No blackhole FDB entry found"

         tcpdump_start $h2
         $MZ $h1 -q -t udp -a $h1 -b $h2
         tcpdump_stop
         tcpdump_show | grep -q udp
         check_fail $? "test_blackhole_fdb: packet seen with blackhole 
fdb entry"
         tcpdump_cleanup

         bridge fdb del `mac_get $h2` dev br0 blackhole
         bridge fdb show dev br0 | grep -q "blackhole"
         check_fail $? "test_blackhole_fdb: Blackhole FDB entry not 
deleted"

         tcpdump_start $h2
         $MZ $h1 -q -t udp -a $h1 -b $h2
         tcpdump_stop
         tcpdump_show | grep -q udp
         check_err $? "test_blackhole_fdb: No packet seen after removing 
blackhole FDB entry"
         tcpdump_cleanup

         log_test "Blackhole FDB entry test"
}

the setup is simple and is the same as in bridge_sticky_fdb.sh.

Does the test look sound or is there obvious mistakes?
