In-Reply-To: <20070926083705.6bc65ea5@fujitsu-loaner>
References: <46FA2C17.76E4.0078.0@novell.com>
	<20070926083705.6bc65ea5@fujitsu-loaner>
Date: Wed, 26 Sep 2007 23:06:53 +0200
Message-Id: <E1Iae5t-0007Sk-Vu@flower>
From: Oleg Verych <olecom@flower.upol.cz>
Subject: [Bridge] why network devices don't do reference counting? (Re:
	[PATCH] Module use count must be updated as bridges are
	created/destroyed)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>

* Wed, 26 Sep 2007 08:37:05 -0700
* Organization: Linux Foundation
>
> On Wed, 26 Sep 2007 08:53:27 +0100
> "Jan Beulich" <jbeulich@novell.com> wrote:
>
>> Otherwise 'modprobe -r' on a module having a dependency on bridge will
>> implicitly unload bridge, bringing down all connectivity that was
>> using bridges.
>> 
>> Signed-off-by: Jan Beulich <jbeulich@novell.com>
>>
>
> No, network devices don't do reference counting.

Could you explain why, please?

After `udevd` on boot loads lots of unused crap, i surrendered, and use
$(rmmod `lsmod | just first column`). Networing bravely wipes away. OK,
there are lots of configs: udev, hotplug, modprobe, that somebody might
like to fix. But it came to the end with me. I just don't care. So,
please answer :)
____
