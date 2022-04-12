Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=1tI3iJnrQlcw0Ck+JWSm8F+BSpbNuEevk2Gd0ETM/CU=;
 b=KBThr/QmH0sNYswb91CdCeH7vHTersHZTKhK9LgK5z9JOlBMl88JDFcUaD8xdyspzj
 3f3PwOUp1XWW+zQl7eetNAFTqNB5RO92A2YLKPvXKcxcw4EyIGyfnMaYW4PDFYa2pYyA
 ZaQq9W4YMjWr1wlLNe77jOAYXrhoHNca35dqJly7IPwqP2QWxa3apCVSso3DjkVQPs54
 E+72+yK+8LuFfe/b8PwgssOY1UMDRZUFklXKimFtPREp0bURQPBtSc83rM/QO9x+tQzS
 TsZqxltKygzyhV5um9vT/ptE0sGxWl/zReXX0f27MDKDqdTDVORg1uYZTFymRfdG5mGl
 4lVA==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <20220411202128.n4dafks4mnkbzr2k@skbuf>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-8-troglobit@gmail.com>
 <20220411202128.n4dafks4mnkbzr2k@skbuf>
Date: Tue, 12 Apr 2022 09:55:31 +0200
Message-ID: <87fsmiburw.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH RFC net-next 07/13] selftests: forwarding: new
	test, verify bridge flood flags
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Apr 11, 2022 at 20:21, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> On Mon, Apr 11, 2022 at 03:38:31PM +0200, Joachim Wiberg wrote:
>> +# Verify per-port flood control flags of unknown BUM traffic.
>> +#
>> +#                     br0
>> +#                    /   \
>> +#                  h1     h2
>
> I think the picture is slightly inaccurate. From it I understand that h1
> and h2 are bridge ports, but they are stations attached to the real
> bridge ports, swp1 and swp2. Maybe it would be good to draw all interfaces.

Hmm, yeah either that or drop it entirely.  I sort of assumed everyone
knew about the h<-[veth]->swp (or actual cable) setup, but you're right
this is a bit unclear.  Me and Tobias have internally used h<-->p (for
host<-->bridge-port) and other similar nomenclature.  Finding a good
name that fits easily, and is still readable, in ASCII drawings is hard.
I'll give it a go in the next drop, thanks!

>> +#set -x
> stray debug line

thx

>> +# Disable promisc to ensure we only receive flooded frames
>> +export TCPDUMP_EXTRA_FLAGS="-pl"
> Exporting should be required only for sub-shells, doesn't apply when you
> source a script.

Ah thanks, will fix!

>> +# Port mappings and flood flag pattern to set/detect
>> +declare -A ports=([br0]=br0 [$swp1]=$h1 [$swp2]=$h2)
> Maybe you could populate the "ports" and the "flagN" arrays in the same
> order, i.e. bridge first for all?

Good point, thanks!

> Also, to be honest, a generic name like "ports" is hard to digest,
> especially since you have another generic variable name "iface".
> Maybe "brports" and "station" is a little bit more specific?

Is there a common naming standard between bridge tests, or is it more
important to be consistent the test overview (test heading w/ picture)?

Anyway, I'll have a look at the naming for the next drop.

>> +declare -A flag1=([$swp1]=off [$swp2]=off [br0]=off)
>> +declare -A flag2=([$swp1]=off [$swp2]=on  [br0]=off)
>> +declare -A flag3=([$swp1]=off [$swp2]=on  [br0]=on )
>> +declare -A flag4=([$swp1]=off [$swp2]=off [br0]=on )
> If it's not too much, maybe these could be called "flags_pass1", etc.
> Again, it was a bit hard to digest on first read.

More like flags_pass_fail, but since its the flooding flags, maybe
flood_patternN would be better?

>> +do_flood_unknown()
>> +{
>> +	local type=$1
>> +	local pass=$2
>> +	local flag=$3
>> +	local pkt=$4
>> +	local -n flags=$5
> I find it slightly less confusing if "flag" and "flags" are next to each
> other in the parameter list, since they're related.

Hmm, OK.

>> +#		echo "Dumping PCAP from $iface, expecting ${flags[$port]}:"
>> +#		tcpdump_show $iface
> Do something about the commented lines.

Oups, thanks!

>> +		tcpdump_show $iface |grep -q "$SRC_MAC"
> Space between pipe and grep.

Will fix!

>> +		check_err_fail "${flags[$port]} = on"  $? "failed flooding from $h1 to port $port"
> I think the "failed" word here is superfluous, since check_err_fail
> already says "$what succeeded, but should have failed".

Ah, good point!

Thank you for the review! <3

 /J
 
