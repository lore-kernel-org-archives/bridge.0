Date: Fri, 5 Oct 2007 09:08:36 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] bridge-utils-1.2 doesn't include configure?
Message-ID: <20071005090836.42b92e6b@freepuppy.rosehill>
In-Reply-To: <7a95bc7b0710050842n7af1a1f7hcf0d8be91654f7e1@mail.gmail.com>
References: <7a95bc7b0710050842n7af1a1f7hcf0d8be91654f7e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: glhs329@gmail.com
Cc: bridge@lists.linux-foundation.org

On Fri, 5 Oct 2007 11:42:19 -0400
glhs329@gmail.com wrote:

> I downloaded bridge-utils-1.2.tar.gz (from
> http://sourceforge.net/project/showfiles.php?group_id=26089), but it
> doesn't include a ./configure script. Was this an oversight? Did I
> miss something? I perused the mail list archive, and this
> https://lists.linux-foundation.org/pipermail/bridge/2006-December/005187.html
> post seems to suggest someone else may have encountered the problem.
> _______________________________________________

You need to run autoconf.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
