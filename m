Date: Sat, 26 Mar 2011 08:55:36 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110326085536.1ef03edb@nehalam>
In-Reply-To: <1301150997-4639-1-git-send-email-sasikanth.v19@gmail.com>
References: <1301150997-4639-1-git-send-email-sasikanth.v19@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] Bridge allows the userspace to configure the
 bridge parameters with values not defined in the IEEE 802.1D std
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

On Sat, 26 Mar 2011 20:19:57 +0530
Sasikanth V <sasikanth.v19@gmail.com> wrote:

> 
> Signed-off-by: Sasikanth V <sasikanth.v19@gmail.com>
> ---

I will clean this up. There are things like introducing
global function names (set_forward_delay, etc) that need
to be fixed.
