From: "D@7@k|N&" <dataking@cox.net>
Subject: RE: [Bridge] Sparc Bridge problems
Date: Mon, 29 Mar 2004 09:43:21 -0800
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAjKi3Hf71/UmVum+JPDLzbOKBAAAQAAAAWdI3Ga8sMEupSQD4+LNt6wEAAAAA@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <564DE4477544D411AD2C00508BDF0B6A1E7E361D@USAHM018.amer.corp.eds.com>
Content-Transfer-Encoding: 8bit
Reply-To: dataking@cox.net
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "'Small, Jim'" <jim.small@EDS.COM>, bridge@osdl.org

 
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks for the info.  Now I won't bother spending all that extra time trying to get Debian up and running just to see if their little utility patch worked.

I think I will have to checkout the 2.6 kernel to see if that makes any difference.  But that means a gcc upgrade!  

Thanks for the help.

- -Charlie

- -----Original Message-----
From: Small, Jim [mailto:jim.small@EDS.COM] 
Sent: Monday, March 29, 2004 9:25 AM
To: D@7@k|N&; bridge@osdl.org
Subject: RE: [Bridge] Sparc Bridge problems

I was never able to get bridging working on the UltraSPARC architecture.
- From what I have gathered, there is some kind of issue between the 32bit
userland (brctl) and 64bit kernel.  If you use Debian, you can get a 64bit
version of brctl, but even with that I could never get it to work.  I could
never find anyone who has gotten it to work on the UltraSPARC/Sparc64
architecture.

If you're a kernel hacker, you might be able to get some help debugging the
problems if you can suggest new code.  Otherwise you'll have to use an x86
based platform (there bridging works beautifully).

Perhaps with time this will bill sorted out in the 2.6 kernel???

<> Jim

> -----Original Message-----
> I'm having a little trouble with a sprc bridge setup.  I am running SuSe
> 7.3 for sparc on a Sun Ultra1 Creator3D.
> I compiled 2.4.25 kernel with 802.1d Ethernet Bridging support, and
> installed
> bridge-utils 0.9.6.  I've read all of the documentation that I could find
> (Bridging FAQ and
> Bridging HOWTO).  But I still get the following errors:
> 
> brctl addbr br0
> brctl addif br0 eth0
> bridge br0 doesn't exist!
> 
> Why not?
> 
> brctl addbr br0
> device br0 already exists; can't create bridge with the same name
> 
> I've found on other mailing-lists that sparc systems require the bridge-
> utils64 package, but can only find it for Debian.
> 
> Any thoughts on what's going on here?  If I compiled the utils from
> source, shouldn't they be the right ones for my system/kernel?
> 
> Any help would be greatly appreciated.


-----BEGIN PGP SIGNATURE-----
Version: PGP 8.0

iQA/AwUBQGhgOabnQHwVWKJjEQLesgCfd/KcUBFqPNdVS2Rjn+/FYbgklYQAnRiG
vGw7lMdJeI2KDlMa7jBNH9V8
=NWIK
-----END PGP SIGNATURE-----



