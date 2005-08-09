Date: Wed, 10 Aug 2005 00:57:14 +0300 (EEST)
From: =?iso-8859-1?Q?Martin-=C9ric_Racine?= <q-funk@iki.fi>
Subject: Re: [Bridge] how to silence the "br0: port X(ethX) doing something"
	messages?
In-Reply-To: <20050809143403.4c0602b9@dxpl.pdx.osdl.net>
Message-ID: <Pine.LNX.4.62.0508100046480.12525@localhost.localdomain>
References: <Pine.LNX.4.62.0508080930090.29573@localhost.localdomain>
	<20050809143403.4c0602b9@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-17507135-1123624634=:12525"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-17507135-1123624634=:12525
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 9 Aug 2005, Stephen Hemminger wrote:

> On Mon, 8 Aug 2005 09:33:06 +0300 (EEST)
> Martin-=C9ric Racine <q-funk@iki.fi> wrote:
>
>> Greetings,
>>
>> I'm just wondering how one can make the bridging tools stop spamming
>> the virtual consoles? I would rather have all those "entering
>> forwarding state", "entering learning state" and "entering disabled
>> state" messages go to a log than have them plastered all over
>> whichever console I happened to be logged into to work.
>>
>> Thanks!
>
> Assuming you are running relatively recent kernel, the messages show up
> at loglevel 6 (informational).

Noted.

Linux omena 2.6.11-imac #2 Thu Jun 23 11:44:22 EEST 2005 ppc GNU/Linux

=2E..and other similar 2.6 kernels also on my i386 and hppa hosts.


> You need to change the console log level and possibly change syslog.conf.

> To change console log level, either boot without "debug" on the command l=
ine,=20
> preferably with "quiet" on the command line.

Sorry, to which kernel option are you refering, exactly?

My bootloader options are already rather spartan as it is; no debug there:

root=3D/dev/hda1 ro elevator=3Dcfq


> In /etc/syslog.conf look for anylines of the form:
>
> =09kern.*=09/dev/console
>
> and either comment it out completely, or change the '*' to
>
> =09kern.notice=09/dev/console

The only item that could reach the console there is:

*.emerg         *

All other logs are configured to go to specific log files.

--=20
Martin-Eric Racine
http://q-funk.iki.fi
--8323328-17507135-1123624634=:12525--
