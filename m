Date: Thu, 12 May 2011 15:59:16 -0700 (PDT)
Message-Id: <20110512.155916.115945119.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110510233540.GJ6397@morgul.net>
References: <20110510180540.GI6397@morgul.net>
	<20110510151100.52a9f8fa@nehalam>
	<20110510233540.GJ6397@morgul.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bug#625914: linux-image-2.6.38-2-amd64: bridging is
 not interacting well with multicast in 2.6.38-4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: noahm@debian.org
Cc: ben@decadent.org.uk, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, 625914@bugs.debian.org

From: Noah Meyerhans <noahm@debian.org>
Date: Tue, 10 May 2011 16:35:40 -0700

> On Tue, May 10, 2011 at 03:11:00PM -0700, Stephen Hemminger wrote:
>> There were two more follow on commits in stable related to this.
>> I recommend merging 2.6.38.6 which includes these.
> 
> The problem still exists in the current 2.6.38.6.  Backing out 5f1c356a
> still solves the problem there.
> 
> I have not yet tried anything outside the stable-2.6.38.y tree, but it
> seems like these same changes are present there, and it's unlikely that
> other releases will work any better.

So the issue is that if we back out that change, we get crashes.

Aparently there is a code path where whatever is existing in the
SKB ip options block matters, and needs to be maintained.

Someone needs to audit all of this and figure out how to fix the
problem properly.
