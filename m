Message-Id: <4DBA87B6020000780003ED74@vpn.id2.novell.com>
Date: Fri, 29 Apr 2011 08:41:10 +0100
From: "Jan Beulich" <JBeulich@novell.com>
References: <4DBA830A020000780003ED5D@vpn.id2.novell.com>
	<20110429.002530.112581952.davem@davemloft.net>
In-Reply-To: <20110429.002530.112581952.davem@davemloft.net>
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jeffm@suse.com

>>> On 29.04.11 at 09:25, David Miller <davem@davemloft.net> wrote:
> From: "Jan Beulich" <JBeulich@novell.com>
> Date: Fri, 29 Apr 2011 08:21:14 +0100
>=20
>> Otherwise 'modprobe -r' on a module having a dependency on bridge will
>> implicitly unload bridge, bringing down all connectivity that was using
>> bridges.
>>=20
>> Signed-off-by: Jan Beulich <jbeulich@novell.com>
>> Cc: Jeff Mahoney <jeffm@suse.com>
>=20
> All network device drivers behave exactly the same way, when you rmmod
> the thing we unconfigure all the routes, addresses, etc. going through
> that device and let you unload it.
>=20
> And this behavior is very much intentional.
>=20
> Don't add an exception here.

You talk of rmmod on the very module, but the issue is about
modprobe -r on a dependent module. I cannot believe you consider
it correct that *implicit* unloading of bridge.ko should happen when
bridges are configured.

If the solution proposed isn't satisfactory, can you suggest a better
alternative still serving the purpose?

Jan

