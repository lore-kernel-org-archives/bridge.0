Date: Wed, 1 Apr 2009 08:52:25 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090401085225.4e1351bb@nehalam>
In-Reply-To: <61aebdcf0904010140l202dae13s46756dfb404590fa@mail.gmail.com>
References: <61aebdcf0904010140l202dae13s46756dfb404590fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] "#brctl show" command output need to be modified
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ahmed AL-Saigh <shabanadevel@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Wed, 1 Apr 2009 10:40:51 +0200
Ahmed AL-Saigh <shabanadevel@gmail.com> wrote:

> This command output should be modified " aligned " to fit the text
> processing tool
> to can understand what I mean  please try to cut the interfaces column with
> any text processing tool
> "awk , cut or even python script"
> but make sure that you have some bridges with some interfaces

Unfortunately existing output format can never be changed because
users already have scripts that parse the existing format.

But, if you want to add a new output format (and option to enable it),
I would be interested in incorporating it. How about:
  brctl --xml show
