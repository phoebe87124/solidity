// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract todoList {
    struct TODO {
        string task;
        bool completed;
    }

    TODO[] public todos;

    function create(string calldata _task) external {
        todos.push(TODO({task: _task, completed: false}));
    }

    function updateTask(uint256 _index, string calldata _task) external {
        // 適合用在改變較少筆/次資料，it will access the array every times
        todos[_index].task = _task;

        // 適合用在改變較多筆/次資料，it only access the array one time
        // TODO storage todo = todos[_index];
        // todo.task = _task;
    }

    function getTask(uint256 _index)
        external
        view
        returns (string memory, bool)
    {
        // execution cost	29387 gas
        TODO storage todo = todos[_index];
        return (todo.task, todo.completed);

        // execution cost	29458 gas
        // TODO memory todo = todos[_index];
        // return (todo.task, todo.completed);

        // execution cost	29565 gas
        // return (todos[_index].task, todos[_index].completed);
    }

    function toggleTask(uint256 _index) external {
        todos[_index].completed = !todos[_index].completed;
    }
}
