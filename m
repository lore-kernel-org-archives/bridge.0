Message-Id: <46FB7A7A.76E4.0078.0@novell.com>
Date: Thu, 27 Sep 2007 08:40:10 +0100
From: "Jan Beulich" <jbeulich@novell.com>
References: <46FA2C17.76E4.0078.0@novell.com>
	<20070926083705.6bc65ea5@fujitsu-loaner>
	<46FAA013.76E4.0078.0@novell.com>
	<20070926101252.3ccbb987@freepuppy.rosehill>
In-Reply-To: <20070926101252.3ccbb987@freepuppy.rosehill>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Re: [PATCH] Module use count must be updated as bridges are
	created/destroyed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

>>> Stephen Hemminger <shemminger@linux-foundation.org> 26.09.07 19:12 >>>
>On Wed, 26 Sep 2007 17:08:19 +0100
>"Jan Beulich" <jbeulich@novell.com> wrote:
>
>> >>> Stephen Hemminger <shemminger@linux-foundation.org> 26.09.07 17:37 >>>
>> >On Wed, 26 Sep 2007 08:53:27 +0100
>> >"Jan Beulich" <jbeulich@novell.com> wrote:
>> >
>> >> Otherwise 'modprobe -r' on a module having a dependency on bridge will
>> >> implicitly unload bridge, bringing down all connectivity that was
>> >> using bridges.
>> >> 
>> >> Signed-off-by: Jan Beulich <jbeulich@novell.com>
>> >>
>> >
>> >No, network devices don't do reference counting.
>> >What is the dependency? Where is the source of the module interacting
>> >with the  bridge?
>> 
>> On a Xen system, I loaded and then unloaded ebtable_broute. The unload
>> implicitly unloaded bridge, destroying the network. The only way I could see
>> to avoid the implicit unload was to bump the reference count on bridge
>> creation. Otherwise I would have to ask why bridge has a zero reference
>> count despite a bridge being configured.
>> 
>> Jan
>
>Sounds like a module utilities problem since unloading one module doesn't
>normally unload others.

I have to disagree here - 'modprobe -r' is specifically unloading all modules the
specified one references as long as they have a use count of zero. The
difference to other networking modules is that the latter normally don't export
symbols, and hence don't have dependent modules (and thus cannot be
subject of implicit unloading). Bridge does have dependents, and hence must
avoid implicit unloading by managing its use count.

Jan


