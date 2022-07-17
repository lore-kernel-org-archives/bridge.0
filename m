Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A133860B89
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94BCE608F5
MIME-Version: 1.0
Date: Sun, 17 Jul 2022 14:21:47 +0200
From: netdev@kapio-technology.com
In-Reply-To: <Ys69DiAwT0Md+6ai@shredder>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-4-netdev@kapio-technology.com>
 <20220708084904.33otb6x256huddps@skbuf>
 <e6f418705e19df370c8d644993aa9a6f@kapio-technology.com>
 <20220708091550.2qcu3tyqkhgiudjg@skbuf>
 <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
 <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
Message-ID: <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 2022-07-13 14:39, Ido Schimmel wrote:
> On Wed, Jul 13, 2022 at 09:09:58AM +0200, netdev@kapio-technology.com 
> wrote:

> 
> What are "Storm Prevention" and "zero-DPV" FDB entries?

They are both FDB entries that at the HW level drops all packets having 
a specific SA, thus using minimum resources.
(thus the name "Storm Prevention" aka, protection against DOS attacks. 
We must remember that we operate with CPU based learning.)

> 
> There is no decision that I'm aware of. I'm simply trying to understand
> how FDB entries that have 'BR_FDB_ENTRY_LOCKED' set are handled in
> mv88e6xxx and other devices in this class. We have at least three
> different implementations to consolidate:
> 
> 1. The bridge driver, pure software forwarding. The locked entry is
> dynamically created by the bridge. Packets received via the locked port
> with a SA corresponding to the locked entry will be dropped, but will
> refresh the entry. On the other hand, packets with a DA corresponding 
> to
> the locked entry will be forwarded as known unicast through the locked
> port.
> 
> 2. Hardware implementations like Spectrum that can be programmed to 
> trap
> packets that incurred an FDB miss. Like in the first case, the locked
> entry is dynamically created by the bridge driver and also aged by it.
> Unlike in the first case, since this entry is not present in hardware,
> packets with a DA corresponding to the locked entry will be flooded as
> unknown unicast.
> 
> 3. Hardware implementations like mv88e6xxx that fire an interrupt upon
> FDB miss. Need your help to understand how the above works there and
> why. Specifically, how locked entries are represented in hardware (if 
> at
> all) and what is the significance of not installing corresponding
> entries in hardware.
> 

With the mv88e6xxx, a miss violation with the SA occurs when there is no 
entry. If you then add a normal entry with the SA, the port is open for 
that SA of course. The zero-DPV entry is an entry that ensures that 
there is no more miss violation interrupts from that SA, while dropping 
all entries with the SA.

