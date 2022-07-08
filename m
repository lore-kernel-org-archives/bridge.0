Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6DC90424E1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A4E84154B
MIME-Version: 1.0
Date: Fri, 08 Jul 2022 14:34:25 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20220708115624.rrjzjtidlhcqczjv@skbuf>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-4-netdev@kapio-technology.com>
 <20220708084904.33otb6x256huddps@skbuf>
 <e6f418705e19df370c8d644993aa9a6f@kapio-technology.com>
 <20220708091550.2qcu3tyqkhgiudjg@skbuf>
 <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
 <20220708115624.rrjzjtidlhcqczjv@skbuf>
Message-ID: <723e2995314b41ff323272536ef27341@kapio-technology.com>
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 2022-07-08 13:56, Vladimir Oltean wrote:
> On Fri, Jul 08, 2022 at 11:50:33AM +0200, netdev@kapio-technology.com 
> wrote:
>> On 2022-07-08 11:15, Vladimir Oltean wrote:
>> > When the possibility for it to be true will exist, _all_ switchdev
>> > drivers will need to be updated to ignore that (mlxsw, cpss, ocelot,
>> > rocker, prestera, etc etc), not just DSA. And you don't need to
>> > propagate the is_locked flag to all individual DSA sub-drivers when none
>> > care about is_locked in the ADD_TO_DEVICE direction, you can just ignore
>> > within DSA until needed otherwise.
>> >
>> 
>> Maybe I have it wrong, but I think that Ido requested me to send it to 
>> all
>> the drivers, and have them ignore entries with is_locked=true ...
> 
> I don't think Ido requested you to ignore is_locked from all DSA
> drivers, but instead from all switchdev drivers maybe. Quite different.

So without changing the signature on port_fdb_add(). If that is to avoid 
changing that signature, which needs to be changed anyhow for any 
switchcore driver to act on it, then my next patch set will change the 
signarure also as it is needed for creating dynamic ATU entries from 
userspace, which is needed to make the whole thing complete.

As it is already done (with the is_locked to the drivers) and needed for 
future application, I would like Ido to comment on it before I take 
action.

> 
> In any case I'm going to take a look at this patch set more closely and
> run the selftest on my Marvell switch, but I can't do this today
> unfortunately. I'll return with more comments.

Yes :-)
