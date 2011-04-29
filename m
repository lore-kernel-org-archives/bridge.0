Message-Id: <4DBAFE45020000780003EEE6@vpn.id2.novell.com>
Date: Fri, 29 Apr 2011 17:07:01 +0100
From: "Jan Beulich" <JBeulich@novell.com>
References: <4DBA87B6020000780003ED74@vpn.id2.novell.com>
	<20110429.011051.183061494.davem@davemloft.net>
	<4DBA937F020000780003ED96@vpn.id2.novell.com>
	<20110429.014445.39196872.davem@davemloft.net>
	<4DBA9C71020000780003EDBE@vpn.id2.novell.com>
	<4DBA9C23.2000408@suse.cz>
	<1304093116.11627.386.camel@constitution.bos.jonmasters.org>
In-Reply-To: <1304093116.11627.386.camel@constitution.bos.jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
To: Jon Masters <jonathan@jonmasters.org>
Cc: Michal Marek <mmarek@suse.cz>, bridge@lists.linux-foundation.org, Jon Masters <jcm@jonmasters.org>, netdev@vger.kernel.org, jeffm@suse.com, David Miller <davem@davemloft.net>

>>> On 29.04.11 at 18:05, Jon Masters <jonathan@jonmasters.org> wrote:
> On Fri, 2011-04-29 at 13:08 +0200, Michal Marek wrote:
>> On 29.4.2011 11:09, Jan Beulich wrote:
>> >>>> On 29.04.11 at 10:44, David Miller<davem@davemloft.net>  wrote:
>=20
>> >> Nothing on the system should be hitting modules with unload requests
>> >> unless the user explicitly asked for that specific module to be
>> >> unloaded.  At least not by default.
>> >>
>> >> So the me the problem is perhaps that "modprobe -r" does this auto
>> >> dependency unloading thing by default.
>> >>
>> >> When we first fixed network device drivers so that they now properly
>> >> always run with no module refcount at all, people complained because
>> >> there were some distributions that ran some daemon that periodically
>> >> looked for "unreferenced" modules and "helped" the user by
>> >> automatically unloaded them.
>> >>
>> >> We killed that foolish daemon, and we can fix "modprobe -r" too.
>> >
>> > Michal - aren't you the modutils maintainer?
>>=20
>> That would be Jon (CC added).
>=20
> Thanks. So the specific feature you mention was added precisely because
> some folks wanted to clean up ununsed modules by removing all of their
> dependencies. Since I've not been on this thread until now, can you let
> me know what precisely you need, and why? We can make the unloading of
> unused modules configurable, but it sounds like you're saying even that
> isn't good enough. What actually happens, what's the bug experience?

The problem observed was that unloading (via modprobe -r)
ebtable_broute.ko, bridge.ko was also unloaded, causing all
bridged networking to stop functioning on a machine.

Jan

