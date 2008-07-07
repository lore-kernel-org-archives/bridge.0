Date: Mon, 7 Jul 2008 16:53:42 -0400
From: Bill Nottingham <notting@redhat.com>
Message-ID: <20080707205342.GA19710@nostromo.devel.redhat.com>
References: <cover.1215460681.git.notting@redhat.com>
	<4872819E.3040604@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4872819E.3040604@trash.net>
Subject: Re: [Bridge] [RFC PATCH 0/2] Allow full bridge configuration via
	sysfs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick McHardy <kaber@trash.net>
Cc: Linux Netdev List <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Patrick McHardy (kaber@trash.net) said: 
> Bill Nottingham wrote:
>> Right now, you can configure most bridge device parameters via sysfs.
>> However, you cannot either:
>> - add or remove bridge interfaces
>> - add or remove physical interfaces from a bridge
>>
>> The attached patch set rectifies this. With this patch set, brctl
>> (theoretically) becomes completely optional, much like ifenslave is
>> now for bonding. (In fact, the idea for this patch, and the syntax
>> used herein, is inspired by the sysfs bonding configuration.)
>
> Both should use netlink instead of extending their sysfs interfaces.
> For bridging I have a patch for the bridge device itself, the API
> is so far missing support for adding ports though.

How does that improve the situation for bridge devices? Are all
bridging parameters (forward_delay, stp, etc.) going to be configurable
via netlink, or would we still then have multiple tools/interfaces
to configuration? Also, moving bonding configuration to netlink seems
like a step backwards.

Bill
