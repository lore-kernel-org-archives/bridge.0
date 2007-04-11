Date: Wed, 11 Apr 2007 10:11:53 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070411101153.4392857c@freekitty>
In-Reply-To: <20070411102717.tfctoalywwwk8skg@webmail.technikum-wien.at>
References: <20070411102717.tfctoalywwwk8skg@webmail.technikum-wien.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] RSTP implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: tw05k121@technikum-wien.at
Cc: bridge@linux-foundation.org, "Aji_Srinivas@emc.com" <Aji_Srinivas@emc.com>

On Wed, 11 Apr 2007 10:27:17 +0200
tw05k121@technikum-wien.at wrote:

> Hi,
> 
> for a universitary project, RSTP (802.1D-2004, Ch. 17) shall be 
> implemented on an embedded linux device.
> 
> My questions: were there any further developments since the version 
> from Marco Goetze, which was available for download on 
> http://linux-net.osdl.org/index.php/Talk:Bridge ?
> On the site is announced that it is unusable and that some pieces are 
> missing. Is there any documentation about 'why' it's unusable and 
> 'what' is missing so somebody (like me) might be able to finish the 
> work?
> 
> 
> thanks in advance for any info!
> 
> Mario Gartner

We are close to having a user level RSTP..  
Aji Srinivas did a version, but it had a number of things I wanted to fix
before releasing. The kernel pieces are in the pre 2.6.22 tree. And
the user-level code is in git tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git

IT DOESN'T WORK YET.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
