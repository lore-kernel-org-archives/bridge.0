Date: Thu, 31 Mar 2011 08:36:02 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110331083602.21946c50@nehalam>
In-Reply-To: <1301423072-28093-1-git-send-email-sasikanth.v19@gmail.com>
References: <1301423072-28093-1-git-send-email-sasikanth.v19@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] Bridge: Removed unwanted check and improper
 usage of bridge locks
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sasikanth V <sasikanth.v19@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Tue, 29 Mar 2011 23:54:32 +0530
Sasikanth V <sasikanth.v19@gmail.com> wrote:


I don't think this is needed because br_dev_open is already covered
by the netlink mutex RTNL
