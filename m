Message-ID: <005801c41a6e$61161b60$0100a8c0@kastrup>
From: =?iso-8859-1?Q?Ferm=EDn_Gal=E1n?= <fgalan@teleline.es>
References: <001901c41415$f8cf2410$f9cd00d5@kastrup>
	<20040401150031.0cc87cb8@dell_ss3.pdx.osdl.net>
Date: Sun, 4 Apr 2004 19:58:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Re: Limitation in virtual bridge number
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

>> My question is due to certain tests that I have
>> performed, the number of virtual bridges cann't be
>> greater than 32. Triying to add the 33rd bridge
>> with 'brctl addbr' works, but causes the removal
>> of the oldest one (the first in the 'brctl show' list):
>> the number of existing virtual bridges is never
>> more than 32.
>
>There were two hard limits, first the command was limited.
>The new bridge-utils 0.9.7 should fix that.  Second, there
>was a kernel limit of 64 which was because of not wanting to
>allocate a lot of memory.  That is now removed in 2.6.5 (post -rc3)
>and I tested with 300+ bridges.

Linux kernel 2.6.5 has been released today, but when the 0.9.7
release of bridge-utils will be released? (in
http://bridge.sourceforge.net/download.html
the last release available for download is 0.9.6)

Thanks!

-------
Ferm=EDn

