Date: Fri, 13 May 2011 11:03:26 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110513110326.60fa09b4@nehalam>
In-Reply-To: <20110510233540.GJ6397@morgul.net>
References: <20110506201234.6297.70279.reportbug@ip6-localhost>
	<1304995124.4065.157.camel@localhost>
	<20110510043833.GG6397@morgul.net>
	<1305031369.4065.259.camel@localhost>
	<20110510180540.GI6397@morgul.net>
	<20110510151100.52a9f8fa@nehalam>
	<20110510233540.GJ6397@morgul.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Noah Meyerhans <noahm@debian.org>
Cc: 625914@bugs.debian.org, bridge@lists.linux-foundation.org, Ben Hutchings <ben@decadent.org.uk>, netdev <netdev@vger.kernel.org>

On Tue, 10 May 2011 16:35:40 -0700
Noah Meyerhans <noahm@debian.org> wrote:

> On Tue, May 10, 2011 at 03:11:00PM -0700, Stephen Hemminger wrote:
> > There were two more follow on commits in stable related to this.
> > I recommend merging 2.6.38.6 which includes these.
> 
> The problem still exists in the current 2.6.38.6.  Backing out 5f1c356a
> still solves the problem there.
> 
> I have not yet tried anything outside the stable-2.6.38.y tree, but it
> seems like these same changes are present there, and it's unlikely that
> other releases will work any better.
> 
> noah
> 

Is this unique to the tap interfaces or does bridging multicast
not work for all devices?


-- 
