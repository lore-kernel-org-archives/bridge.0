Date: Fri, 29 Apr 2011 01:44:45 -0700 (PDT)
Message-Id: <20110429.014445.39196872.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4DBA937F020000780003ED96@vpn.id2.novell.com>
References: <4DBA87B6020000780003ED74@vpn.id2.novell.com>
	<20110429.011051.183061494.davem@davemloft.net>
	<4DBA937F020000780003ED96@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Module use count must be updated as
 bridges are created/destroyed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: JBeulich@novell.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jeffm@suse.com

From: "Jan Beulich" <JBeulich@novell.com>
Date: Fri, 29 Apr 2011 09:31:27 +0100

>>>> On 29.04.11 at 10:10, David Miller <davem@davemloft.net> wrote:
>> From: "Jan Beulich" <JBeulich@novell.com>
>> Date: Fri, 29 Apr 2011 08:41:10 +0100
>> 
>>> You talk of rmmod on the very module, but the issue is about
>>> modprobe -r on a dependent module. I cannot believe you consider
>>> it correct that *implicit* unloading of bridge.ko should happen when
>>> bridges are configured.
>> 
>> Which module in particular depends upon bridge and causes the
>> problem?
> 
> The problem was observed (a long time ago) with ebtable_broute,
> and I cannot see how this would have changed meanwhile.

Well your change makes it so that someone who actually _wants_ to
unload the bridge module, regardless of configuration, cannot do so.

I think that's a worse problem than this ebtables thing.

Nothing on the system should be hitting modules with unload requests
unless the user explicitly asked for that specific module to be
unloaded.  At least not by default.

So the me the problem is perhaps that "modprobe -r" does this auto
dependency unloading thing by default.

When we first fixed network device drivers so that they now properly
always run with no module refcount at all, people complained because
there were some distributions that ran some daemon that periodically
looked for "unreferenced" modules and "helped" the user by
automatically unloaded them.

We killed that foolish daemon, and we can fix "modprobe -r" too.

Does "rmmod" have this behavior too?  If not, and it does the right
thing by only unloaded what the user asked for, then people should
use that.

I really don't in any way want to block people from being able to
cleanly unload the bridge module, regardless of configuration, if
that's what they want so your patch as written is not going to be
considered for inclusion.

