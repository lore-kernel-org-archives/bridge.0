Message-ID: <406B00E7.5040000@us.ibm.com>
Date: Wed, 31 Mar 2004 12:33:27 -0500
From: Santiago Leon <santil@us.ibm.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Sparc Bridge problems
References: <564DE4477544D411AD2C00508BDF0B6A1E7E361D@USAHM018.amer.corp.eds.com>
In-Reply-To: <564DE4477544D411AD2C00508BDF0B6A1E7E361D@USAHM018.amer.corp.eds.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "Small, Jim" <jim.small@eds.com>
Cc: bridge@osdl.org, "D@7@k|N&" <dataking@cox.net>

I had the exact same problem a while ago on a 64-bit PowerPC and hacked 
my way around it... (can't seem to find the patch now, though)...  The 
first thing you want to do is run:
brctl addbr br0
strace brctl addif br0 eth0

and look for what ioctl fails... Post that output and I might be able to 
point you to the solution...

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

Small, Jim wrote:

>I was never able to get bridging working on the UltraSPARC architecture.
>>From what I have gathered, there is some kind of issue between the 32bit
>userland (brctl) and 64bit kernel.  If you use Debian, you can get a 64bit
>version of brctl, but even with that I could never get it to work.  I could
>never find anyone who has gotten it to work on the UltraSPARC/Sparc64
>architecture.
>
>If you're a kernel hacker, you might be able to get some help debugging the
>problems if you can suggest new code.  Otherwise you'll have to use an x86
>based platform (there bridging works beautifully).
>
>Perhaps with time this will bill sorted out in the 2.6 kernel???
>
><> Jim
>
>  
>
>>-----Original Message-----
>>I'm having a little trouble with a sprc bridge setup.  I am running SuSe
>>7.3 for sparc on a Sun Ultra1 Creator3D.
>>I compiled 2.4.25 kernel with 802.1d Ethernet Bridging support, and
>>installed
>>bridge-utils 0.9.6.  I've read all of the documentation that I could find
>>(Bridging FAQ and
>>Bridging HOWTO).  But I still get the following errors:
>>
>>brctl addbr br0
>>brctl addif br0 eth0
>>bridge br0 doesn't exist!
>>
>>Why not?
>>
>>brctl addbr br0
>>device br0 already exists; can't create bridge with the same name
>>
>>I've found on other mailing-lists that sparc systems require the bridge-
>>utils64 package, but can only find it for Debian.
>>
>>Any thoughts on what's going on here?  If I compiled the utils from
>>source, shouldn't they be the right ones for my system/kernel?
>>
>>Any help would be greatly appreciated.
>>    
>>
