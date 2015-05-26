Return-Path: <stephen@networkplumber.org>
Date: Tue, 26 May 2015 10:28:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20150526102809.5c3e8abc@urahara>
In-Reply-To: <1432204977-4293-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1432204977-4293-1-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: skip fdb add if the port
 shouldn't learn
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, wkok@cumulusnetworks.com

On Thu, 21 May 2015 03:42:57 -0700
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> From: Wilson Kok <wkok@cumulusnetworks.com>
> 
> Check in fdb_add_entry() if the source port should learn, similar
> check is used in br_fdb_update.
> Note that new fdb entries which are added manually or
> as local ones are still permitted.
> This patch has been tested by running traffic via a bridge port and
> switching the port's state, also by manually adding/removing entries
> from the bridge's fdb.
> 
> Signed-off-by: Wilson Kok <wkok@cumulusnetworks.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

What is the problem this is trying to solve?

I think user should be allowed to manually add any entry
even if learning.
