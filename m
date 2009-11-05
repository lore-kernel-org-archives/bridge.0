Date: Thu, 5 Nov 2009 00:34:07 -0500 (EST)
From: Jon Lewis <jlewis@lewis.org>
In-Reply-To: <Pine.LNX.4.61.0911041654570.22812@soloth.lewis.org>
Message-ID: <Pine.LNX.4.61.0911050029220.22812@soloth.lewis.org>
References: <Pine.LNX.4.61.0911040949290.22812@soloth.lewis.org>
	<4AF1F6AE.9050506@pandora.be>
	<Pine.LNX.4.61.0911041654570.22812@soloth.lewis.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Bridge] ebtables counters bug
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: Bridge@lists.linux-foundation.org

On Wed, 4 Nov 2009, Jon Lewis wrote:

> Cool.  I was going to check out a copy from cvs, but the instructions at
> http://ebtables.sourceforge.net/downloads/cvs.html
> seem to be out of date, and anonymous access to 
> cvs.sourceforge.net:/cvsroot/ebtables is denied.
>
> $ cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/ebtables login
> Logging in to :pserver:anonymous@cvs.sourceforge.net:2401/cvsroot/ebtables
> CVS password:
> cvs [login aborted]: connect to [cvs.sourceforge.net]:2401 failed: Connection 
> refused

I tried a little harder and figured out the cvs issue.  The instructions 
on the sourceforce web page are outdated.  The cvs server should be 
ebtables.cvs.sourceforge.net.

I just rebuilt ebtables with your patch to communication.c and it seems to 
solve the problem.  Thanks.

----------------------------------------------------------------------
  Jon Lewis                   |  I route
  Senior Network Engineer     |  therefore you are
  Atlantic Net                |
_________ http://www.lewis.org/~jlewis/pgp for PGP public key_________
