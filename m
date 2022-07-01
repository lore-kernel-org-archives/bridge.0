Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B25ED83F26
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64FD683E79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCjr+f7uZ5DC0YbdbPOnjOwPt+ZQMquVRpoMqubuKm4=;
 b=c+yZzSDubRBaYytIWeW4oJ58SPnAfbo44YoInD0HB91t1XXNSq9GT8hH0zbzhnuEYBI2C3f7Y+wpxTxFDxC5MdJUvekxIt5EbvCXn3+/PxfDlb5+5YuJ1NLerN8iH1f7T7I8BUutwQ8n/ugx+vSl9EcOy1LydocMEiiGJGIlsT7cRJXmyKgNHF8uRjZRgQyzSsrbIqjgFQU0RHwjWhwcJI9ZUK6Ho7bZAr8HA2TgpN6i2wWKOZoEa4AjyLTvr+WJa38qpvRhlcHOhHMrS4lL4X0qfvoVsDR9T3XsEUmMJ8627wKyZ2BwnRXF/SDNnYMOCceQ5nbuFcOGZ/WM2E62gA==
Date: Fri, 1 Jul 2022 20:00:45 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Yr8oPba83rpJE3GV@shredder>
References: <20220630111634.610320-1-hans@kapio-technology.com>
 <Yr2LFI1dx6Oc7QBo@shredder>
 <CAKUejP6LTFuw7d_1C18VvxXDuYaboD-PvSkk_ANSFjjfhyDGkg@mail.gmail.com>
 <Yr778K/7L7Wqwws2@shredder>
 <CAKUejP5w0Dn8y9gyDryNYy7LOUytqZsG+qqqC8JhRcvyC13=hQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUejP5w0Dn8y9gyDryNYy7LOUytqZsG+qqqC8JhRcvyC13=hQ@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v1 1/1] net: bridge: ensure that
 link-local traffic cannot unlock a locked port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans S <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 06:07:10PM +0200, Hans S wrote:
> There is several issues when learning is turned off with the mv88e6xxx driver:

Please don't top-post...

> 
> Mac-Auth requires learning turned on, otherwise there will be no miss
> violation interrupts afair.
> Refreshing of ATU entries does not work with learning turn off, as the
> PAV is set to zero when learning is turned off.
> This then further eliminates the use of the HoldAt1 feature and
> age-out interrupts.
> 
> With dynamic ATU entries (an upcoming patch set), an authorized unit
> gets a dynamic ATU entry, and if it goes quiet for 5 minutes, it's
> entry will age out and thus get removed.
> That also solves the port relocation issue as if a device relocates to
> another port it will be able to get access again after 5 minutes.

You assume I'm familiar with mv88e6xxx, when in fact I'm not. Here is
what I think you are saying:

1. When a port is locked and a packet is received with a SA that is not
in the FDB, it will only generate a miss violation if learning is
enabled. In which case, you will notify the bridge driver about this
entry as externally learned and locked entry.

2. When a port is locked and a packet is received with a SA that matches
a different port, it will be dropped regardless if learning is enabled
or not.

3. From the above I conclude that the HW will not auto-populate its FDB
when a port is locked.

4. FDB entries that point to a port that does not have learning enabled
are not subject to ageing (why?).

Assuming the above is correct, in order for mv88e6xxx to work correctly,
it needs to enable learning on all locked ports, but it should happen
regardless of the bridge driver learning configuration let alone impose
any limitations on it. In fact, hostapd must disable learning for all
locked ports.
